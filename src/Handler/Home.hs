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
        addScriptRemote("https://unpkg.com/jquery")
        addScriptRemote("https://surveyjs.azureedge.net/1.1.22/survey.jquery.js")
        toWidget $(juliusFile "templates/frases.julius")
    
    
    
    
    
    
    <script src="/static/js/jquery.js">
<script src="/static/js/jquery.scrollTo.js">
<script src="/static/js/jquery.nav.js">
<script src="/static/js/jquery.localScroll.js">
<script src="/static/js/bootstrap.js">
<script src="/static/js/jquery.prettyPhoto.js">
<script src="/static/js/isotope.js">
<script src="/static/js/jquery.flexslider.js">
<script src="/static/js/inview.js">
<script src="/static/js/animate.js">
<script src="/static/js/custom.js">




<link href="/static/css/bootstrap-responsive.css" rel="stylesheet">
<link href="/static/css/style.css" rel="stylesheet">
<link href="https://surveyjs.azureedge.net/1.1.22/modern.css" type="text/css" rel="stylesheet">
<link href="/static/css/default.css" rel="stylesheet">
<link rel="stylesheet" href="/static/css/page.css">

<link rel="shortcut icon" href="/static/images/favicon.ico">