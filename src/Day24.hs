{-|
Module      : Day24
Description : Day 24: Lobby Layout

<https://adventofcode.com/2020/day/24>
-}

module Day24 where

import Advent

import Data.Map (Map, alter, empty)

data Direction = E | W | NW | NE | SW | SE deriving (Enum, Show)

type Coords = (Int, Int, Int)

parseLine :: String -> [Direction]
parseLine [] = []
parseLine ('e':xs) = E : parseLine xs
parseLine ('w':xs) = W : parseLine xs
parseLine ('s':'e':xs) = SE : parseLine xs
parseLine ('s':'w':xs) = SW : parseLine xs
parseLine ('n':'e':xs) = NE : parseLine xs
parseLine ('n':'w':xs) = NW : parseLine xs

updCoords :: Direction -> Coords -> Coords
updCoords NW (x,y,z) = (x, y+1, z-1)
updCoords NE (x,y,z) = (x+1, y, z-1)
updCoords W (x,y,z) = (x-1, y+1, z)
updCoords E (x,y,z) = (x+1, y-1, z)
updCoords SW (x,y,z) = (x-1, y, z+1)
updCoords SE (x,y,z) = (x, y-1, z+1)

flipTile :: Maybe Bool -> Maybe Bool
flipTile (Just True) = Nothing
flipTile _ = Just True

flipTiles :: [[Direction]] -> Map Coords Bool
flipTiles = foldl (flip (alter flipTile)) empty . map (foldl (flip updCoords) (0,0,0))

neighbors :: Coords -> [Coords]
neighbors = mapM updCoords (enumFrom E)

main = do
    input <- parsedInput 24 (map parseLine . lines)
    print $ (length . flipTiles) input
