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

data FileForm = FileForm
    { fileInfo :: FileInfo
        , fileDescription :: Text
    }

getHomeR :: Handler Html
getHomeR = do
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
    
