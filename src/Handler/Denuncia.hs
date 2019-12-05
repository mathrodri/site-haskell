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
    name <- lookupPostParam "name"
    email <- lookupPostParam "email"
    subject <- lookupPostParam "subject"
    message <- lookupPostParam "message"
    runDB $ insert Denuncia name email subject message
    redirect HomeR
    
