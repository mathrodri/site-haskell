{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Text.Lucius
import Text.Julius
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql


formDenuncia :: Form Denuncia 
formDenuncia = renderBootstrap $ Denuncia
    <$> areq textField "Nome: " Nothing
    <*> areq emailField "Email: " Nothing
    <*> areq textField "Assunto: " Nothing
    <*> areq textField "Mensagem: " Nothing

getHomeR :: Handler Html
getHomeR = do
    (widget, _) <- generateFormPost formDenuncia
    defaultLayout $ do
        toWidgetHead [hamlet|
            <meta charset="utf-8">
            <title>
                Coach no teu Fique esperto!
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="Coach e seus fracassos">
            <meta name="author" content="">
        |]
        $(whamletFile "templates/homepage.hamlet")
        toWidget
            [whamlet|
    
                <h1>
                    CADASTRO DE Denuncia
    
                <form method=post action=@{DenunciaR}>
                    ^{widget}
                    <input type="submit" value="Cadastrar">
            |]
        $(whamletFile "templates/footer.hamlet")
        
postDenunciaR :: Handler Html
postDenunciaR = do
    ((result,_),_) <- runFormPost formDenuncia
    case result of 
        FormSuccess denuncia -> do 
            runDB $ insert denuncia 
            setMessage [shamlet|
                <div>
                    Denuncia feita com sucesso.
            |]
            redirect HomeR
        _ -> redirect HomeR
    redirect HomeR