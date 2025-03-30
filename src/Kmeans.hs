{-
-- EPITECH PROJECT, 2025
-- Image_compressor
-- File description:
-- Kmeans
-}

module Kmeans (kmeans) where

import Kmeans_helper (euclideanDistance, computeCentroid)
import Data.List (minimumBy)   
import Data.Ord (comparing)
import Utils (Color)

initializeCentroids :: Int -> [Color] -> [Color]
initializeCentroids k colors = take k colors

assignToClusters :: [Color] -> [Color] -> [[Color]]
assignToClusters centroids colors =
    let findClosest c = minimumBy (comparing (euclideanDistance c)) centroids
    in [[c | c <- colors, findClosest c == centroid] | centroid <- centroids]

updateCentroids :: [[Color]] -> [Color]
updateCentroids = map computeCentroid

hasConverged :: [Color] -> [Color] -> Bool
hasConverged old new = old == new

kmeans :: Int -> [Color] -> [[Color]]
kmeans k colors = loop (initializeCentroids k colors)
  where
    loop centroids
        | hasConverged centroids newCentroids = clusters
        | otherwise = loop newCentroids
        where
            clusters = assignToClusters centroids colors
            newCentroids = updateCentroids clusters
