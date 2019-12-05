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

--T6DQ0klE

getHomeR :: Handler Html
getHomeR = do
    (widget, _) <- generateFormPost formDenuncia
    defaultLayout $ do
        setTitle "Coach no teu Cool"
        toWidgetHead [hamlet|
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="Coach e seus fracassos">
            <meta name="author" content="">
        |]
        toWidgetHead [lucius|
            .control-group.clearfix.required {
                width: 50%;
                margin: 0 auto;
            }
            
            .control-group.clearfix.required input{
                width: 100%;
                height: 40px;
            }
        |]
        $(whamletFile "templates/homepage.hamlet")
        toWidget
            [whamlet|
                <section .section .orange #contact>
                    <div .container>
                        <h4>Denuncie ou Conte seu caso para nós!
                        <p>Nossa missão é encaminhar e fazer barulho para aqueles que usam de má fé, que vendem promessas milagrosas, então a melhor maneira para coibir esse tipo de atividade é denunciar. Deixe sua mensagem aqui, prometemos que vamos checar e passar sua história adiante.
                        <div .row>
                            <div .span6>
                                <div .blankdivider30>
                                <div .row>
                                    <div .span12>
                                        <div .cform #contact-form>
                                            <form method=post action=@{HomeR}>
                                                ^{widget}
                                                <input type="submit" #btn-denuncia value="Enviar" style="margin: 0 auto;">
            |]
        $(whamletFile "templates/footer.hamlet")
        
postHomeR :: Handler Html
postHomeR = do
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