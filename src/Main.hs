{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Main
-}

module Main where

import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(..), exitFailure)
import Data.Maybe (mapMaybe)
import Kmeans (kmeans)
import Parser (parseLine)
import Control.Exception (IOException)
import System.IO.Error (catchIOError)
import Utils (Pixel)



readPixels :: FilePath -> IO [Pixel]
readPixels path =
    catchIOError (readFile path >>= processContent) handleReadError
  where
    processContent content =
        let parsed = mapMaybe parseLine (lines content)
        in case parsed of
            [] -> putStrLn "Error: Could not parse file" 
                    >> exitWith (ExitFailure 84)
            _  -> return parsed

handleReadError :: IOException -> IO [Pixel]
handleReadError _ = putStrLn "Error: Could not read file" 
                    >> exitWith (ExitFailure 84) 
                    >> return []

parseArgs :: [String] -> IO (Int, Double, FilePath)
parseArgs ["-n", nStr, "-l", lStr, "-f", filePath] =
    case (reads nStr, reads lStr) of
        ([(n, "")], [(l, "")]) | n > 0 && l >= 0 -> return (n, l, filePath)
        _ -> printUsage
parseArgs _ = printUsage

printUsage :: IO a
printUsage = putStrLn "USAGE: ./imageCompressor -n N -l L -f F" >> exitFailure

runKMeans :: Int -> Double -> [Pixel] -> IO ()
runKMeans n _ pixels =
    mapM_ printCluster (kmeans n (map snd pixels))
  where
    printCluster (centroid:cluster) =
        putStrLn "--" >>
        print centroid >>
        putStrLn "-" >>
        mapM_ (printPixel cluster) pixels
    printCluster [] = return ()

    printPixel cluster (pos, color)
        | color `elem` cluster = putStrLn (show pos ++ " " ++ show color)
        | otherwise = return ()

main :: IO ()
main = do
    args <- getArgs
    (n, l, filePath) <- parseArgs args
    pixels <- readPixels filePath
    runKMeans n l pixels
