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

data FileForm = FileForm
    { fileInfo :: FileInfo
        , fileDescription :: Text
    }

postDenunciaR :: Handler Html
postDenunciaR = do
    nome <- lookupPostParam "name"
    email <- lookupPostParam "email"
    assunto <- lookupPostParam "subject"
    mensagem <- lookupPostParam "message"
    insertedDenuncia <- runDB $ insert $ Denuncia nome email assunto mensagem
    redirect HomeR
    
