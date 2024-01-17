extends Node

var money = 50
var CastleHP = 10
var score = 0
var Highscore = 0
var timer:float =0.000 

var char_data = {
	
	"Miner": {
		"damage" : 1,
		"range": 15,
		"cost":50},
	
	"Mage": {
		"damage" : 1,
		"range": 350,
		"cost":600},

	"MeeleSpawner": {
		"damage" : 1,
		"range": 15,
		"cost":150},

	"Tank":{
		"damage" : 1,
		"range": 50,
		"cost":200
	}
		}

