const express = require('express');
const router = express.Router();
const pool = require('../config/db');

const jwtMiddleware = require('../tokenize')

const users = require('../handlers/users')
const auth = require('../handlers/auth')
const recipes = require('../handlers/recipes')
const ingredients = require('../handlers/recipe/:recipe_id/ingredients')
const steps = require('../handlers/recipe/:recipe_id/steps')

// public routes
router.post("/register", users.postNewUserHandler(pool))
router.post("/login", auth.postLoginHandler(pool))

// protected routes
router.get("/user", jwtMiddleware, users.getUserHandler(pool))
// router.put("user/image", jwtMiddleware, userUpload.single('image'), users.putUserImageHandler)

router.get("/recipes", jwtMiddleware, recipes.getAllRecipes(pool))

router.get("/recipe/:recipe_id/ingredients", jwtMiddleware, ingredients.getIngredientsByRecipeId(pool))

router.get("/recipe/:recipe_id/steps", jwtMiddleware, steps.getStepsByRecipeId(pool))


// router.post("recipe/image")
// router.get("recipes/my")

module.exports = router
