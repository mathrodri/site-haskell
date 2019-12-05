{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Denuncia where

import Import
import Text.Lucius
import Text.Julius
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Yesod.Form

data FileForm = FileForm
    { fileInfo :: FileInfo
        , fileDescription :: Text
    }

formDenuncia :: Form Denuncia 
formDenuncia = renderBootstrap $ Denuncia
    <$> areq textField "Nome: " Nothing
    <*> areq emailField "Email: " Nothing
    <*> areq textField "Assunto: " Nothing
    <*> areq textField "Mensagem: " Nothing

-- T6DQ0klE

getDenunciaR :: Handler Html
getDenunciaR = do 
    (widget, _) <- generateFormPost formDenuncia 
    defaultLayout $ do 
        [whamlet|

            <h1>
                CADASTRO DE Denuncia

            <form method=post action=@{DenunciaR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

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
    
