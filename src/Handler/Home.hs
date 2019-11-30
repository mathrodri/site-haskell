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
        [whamlet|
            <meta charset="utf-8">
        	<title>
        	    Coach no teu Fique esperto!
        	<meta name="viewport" content="width=device-width, initial-scale=1.0">
        	<meta name="description" content="Coach e seus fracassos">
        	<meta name="author" content="">
        	<link href="/static/css/bootstrap-responsive.css" rel="stylesheet">
        	<link href="/static/css/style.css" rel="stylesheet">
        	<link href="/static/css/default.css" rel="stylesheet">
        	<link rel="shortcut icon" href="/static/images/favicon.ico">
        	<script src="https://unpkg.com/jquery">
            <script src="https://surveyjs.azureedge.net/1.1.22/survey.jquery.js">
            <link href="https://surveyjs.azureedge.net/1.1.22/modern.css" type="text/css" rel="stylesheet">
        	<link rel="stylesheet" href="/static/css/page.css">
        |]
        $(whamletFile "templates/homepage.hamlet")
    
