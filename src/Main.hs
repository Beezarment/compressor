{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Main
-}

module Main where

import System.Environment (getArgs)
import Parser (parseLine)
import Kmeans (kmeans)

main :: IO ()
main = putStrLn "Image Compressor Running..."

errorExit :: IO ()
errorExit = ioError (userError "Exit with error code 84")
