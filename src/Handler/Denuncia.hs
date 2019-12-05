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
import Yesod.Form.Bootstrap3

data FileForm = FileForm
    { fileInfo :: FileInfo
        , fileDescription :: Text
    }

formDenuncia :: Form Denuncia 
formDenuncia = renderBootstrap $ Denuncia
    <$> areq textField "Nome: " Nothing
    <*> areq dayField "Email: " Nothing
    <*> areq textField "Assunto: " Nothing
    <*> areq textField "Mensagem: " Nothing

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
    -- redirect HomeR
    
