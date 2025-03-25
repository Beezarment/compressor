{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Parser
-}

module Parser (parseLine) where

import Text.Read (readMaybe)

splitLine :: String -> Maybe (String, String)
splitLine line =
    case words line of
        [pos, col] -> Just (pos, col)
        _ -> Nothing

parsePoint :: String -> Maybe (Int, Int)
parsePoint s =
    case s of
        ('(':xs) | last xs == ')' -> readMaybe (init xs)
        _ -> Nothing

parseColor :: String -> Maybe (Int, Int, Int)
parseColor s =
    case s of
        ('(':xs) | last xs == ')' -> readMaybe (init xs)
        _ -> Nothing

parseLine :: String -> Maybe ((Int, Int), (Int, Int, Int))
parseLine line = do
    (pos, col) <- splitLine line
    p <- parsePoint pos
    c <- parseColor col
    return (p, c)