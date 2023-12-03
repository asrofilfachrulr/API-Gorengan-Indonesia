const express = require('express');
const multer = require('multer');
const router = express.Router();
const { pool } = require('../config/db');

const memoryStorage = multer.memoryStorage;
const upload = multer({memoryStorage})

const {verifyJwtToken} = require('../middleware/jwt')
const storageMiddleware = require('../middleware/storage')
const recipeMiddleware = require("../middleware/recipe")

const users = require('../handlers/users')
const auth = require('../handlers/auth')
const recipes = require('../handlers/recipes')
const categories = require("../handlers/categories")
const recipe = require("../handlers/recipe")
const ingredients = require('../handlers/recipe/:recipe_id/ingredients')
const steps = require('../handlers/recipe/:recipe_id/steps')
const ratings = require('../handlers/recipe/:recipe_id/ratings')
const favourites = require('../handlers/favourites')
const favourite = require('../handlers/recipe/:recipe_id/favourite')

const userStorageService = require("../services/supabase/storage/user")
const recipeStorageService = require("../services/supabase/storage/recipe")

const testStorage = require('../handlers/test/storage')

// public routes
router.post("/register", users.postNewUserHandler(pool))
router.post("/login", auth.postLoginHandler(pool))

// protected routes

// user route
router.get("/user", verifyJwtToken, users.getUserHandler(pool))
router.put("/user/bio", verifyJwtToken, users.putUserBioHandler(pool))
router.put(
  "/user/bio/img", 
  verifyJwtToken,
  upload.single('file'), 
  storageMiddleware.uploadFile(userStorageService),
  users.putUserImageHandler(pool)
)
router.put("/user/password", verifyJwtToken, auth.resetPassword(pool))

// category route
router.get("/categories", categories.getCategories(pool))

// recipe route
router.get("/recipes", verifyJwtToken, recipes.getAllRecipes(pool))

router.get("/recipe/:recipe_id", recipe.getRecipeById(pool))
router.post(
  "/recipe", 
  verifyJwtToken, 
  upload.single('file'),
  storageMiddleware.uploadFile(recipeStorageService),
  recipe.postRecipe(pool)
)
router.put("/recipe/:recipe_id", verifyJwtToken, recipe.putRecipe(pool))
router.delete("/recipe/:recipe_id", verifyJwtToken, recipe.deleteRecipe(pool))

router.get("/recipe/:recipe_id/ingredients", verifyJwtToken, ingredients.getIngredientsByRecipeId(pool))
router.put("/recipe/:recipe_id/ingredients", verifyJwtToken, ingredients.putIngredientsByRecipeId(pool))

router.get("/recipe/:recipe_id/steps", verifyJwtToken, steps.getStepsByRecipeId(pool))
router.put("/recipe/:recipe_id/steps", verifyJwtToken, steps.putStepsByRecipeId(pool))

router.put(
  "/recipe/:recipe_id/img", 
  verifyJwtToken, 
  recipeMiddleware.recipeAuthorization(pool),
  upload.single('file'),
  storageMiddleware.uploadFile(recipeStorageService),
  recipe.putRecipeImage(pool)
)

router.get("/recipe/:recipe_id/ratings", verifyJwtToken, ratings.getRatingsByRecipeId(pool))
router.post("/recipe/:recipe_id/rating", verifyJwtToken, ratings.postRatingByRecipeId(pool))
router.put("/recipe/:recipe_id/rating", verifyJwtToken, ratings.putRatingByRecipeId(pool))
router.delete("/recipe/:recipe_id/rating", verifyJwtToken, ratings.deleteRatingByRecipeId(pool))
router.post("/recipe/:recipe_id/favourite", verifyJwtToken, favourite.postFavourite(pool))
router.delete("/recipe/:recipe_id/favourite", verifyJwtToken, favourite.deleteFavourite(pool))

router.get("/favourites", verifyJwtToken, favourites.getAllFavourites(pool))

router.get("/test/storage/uploadImg", testStorage.testUploadImg)

// router.post("recipe/image")
// router.get("recipes/my")

module.exports = router
