{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Parser
-}

module Parser (parseLine) where

import Text.Read (readMaybe)
import Utils (Pos, Color, Pixel)

splitLine :: String -> Maybe (String, String)
splitLine line =
  case words line of
    [pos, col] -> Just (pos, col)
    _          -> Nothing

parsePoint :: String -> Maybe Pos
parsePoint s =
  case (s, reverse s) of
    (('(' : _), (')' : _)) -> readMaybe s
    _                      -> Nothing

parseColor :: String -> Maybe Color
parseColor s =
  case (s, reverse s) of
    (('(' : _), (')' : _)) -> readMaybe s
    _                      -> Nothing

parseLine :: String -> Maybe Pixel
parseLine line = do
  (pos, col) <- splitLine line
  p <- parsePoint pos
  c <- parseColor col
  return (p, c)