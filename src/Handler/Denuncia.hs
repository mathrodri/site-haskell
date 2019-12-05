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


getListDenunciaR :: Handler Html
getListDenunciaR = do
    -- select * from denuncia order by denuncia.nome
    denuncias <- runDB $ selectList [] [Asc DenunciaNome]
    defaultLayout $ do 
        $(whamletFile "templates/denuncia.hamlet")