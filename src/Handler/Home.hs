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
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_main_css)
        addStylesheet (StaticR css_home_css)
        addScript (StaticR js_quiz_js)
        [whamlet|
            <meta charset="UTF-8">
            <meta name="description" content="">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Site
        |]
        $(whamletFile "templates/homepage.hamlet")
    
