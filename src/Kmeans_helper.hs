{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Kmeans_helper
-}

module Kmeans_helper (euclideanDistance, computeCentroid) where

euclideanDistance :: (Int, Int, Int) -> (Int, Int, Int) -> Double
euclideanDistance (r1, g1, b1) (r2, g2, b2) =
    sqrt (fromIntegral ((r1 - r2) ^ (2 :: Int) + (g1 - g2) ^ (2 :: Int) + (b1 - b2) ^ (2 :: Int)))

computeCentroid :: [(Int, Int, Int)] -> (Int, Int, Int)
computeCentroid colors =
    let (rSum, gSum, bSum, count) = foldl (\(r, g, b, n) (r', g', b') ->
                                            (r + r', g + g', b + b', n + 1))
                                            (0, 0, 0, 0) colors
    in (rSum `div` count, gSum `div` count, bSum `div` count)
