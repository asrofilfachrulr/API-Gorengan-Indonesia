const express = require('express');
const multer = require('multer');
const router = express.Router();
const pool = require('../config/db');

const memoryStorage = multer.memoryStorage;
const upload = multer({memoryStorage})

const {verifyJwtToken} = require('../middleware/jwt')
const storageMiddleware = require('../middleware/storage')

const users = require('../handlers/users')
const auth = require('../handlers/auth')
const recipes = require('../handlers/recipes')
const ingredients = require('../handlers/recipe/:recipe_id/ingredients')
const steps = require('../handlers/recipe/:recipe_id/steps')
const ratings = require('../handlers/recipe/:recipe_id/ratings')
const favourites = require('../handlers/favourites')
const favourite = require('../handlers/recipe/:recipe_id/favourite')

const userStorageService = require("../services/supabase/storage/user")

const testStorage = require('../handlers/test/storage')

// public routes
router.post("/register", users.postNewUserHandler(pool))
router.post("/login", auth.postLoginHandler(pool))

// protected routes
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
// router.put("user/image", verifyJwtToken, userUpload.single('image'), users.putUserImageHandler)

router.get("/recipes", verifyJwtToken, recipes.getAllRecipes(pool))

router.get("/recipe/:recipe_id/ingredients", verifyJwtToken, ingredients.getIngredientsByRecipeId(pool))

router.get("/recipe/:recipe_id/steps", verifyJwtToken, steps.getStepsByRecipeId(pool))

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
