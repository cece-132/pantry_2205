require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'

RSpec.describe do Pantry
    before :each do
        @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
        @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 200})
        @pantry = Pantry.new
    end

    it 'exists and has attributes' do
        expect(@pantry).to be_a Pantry
        expect(@pantry.stock).to eq({})
    end

    it 'can check stock' do
        expect(@pantry.stock_check(@ingredient1)).to eq 0
    end

    it 'can restock items' do
        @pantry.restock(@ingredient1, 5)
        @pantry.restock(@ingredient1, 10)
        
        expect(@pantry.stock_check(@ingredient1)).to eq 15

        @pantry.restock(@ingredient2, 7)

        expect(@pantry.stock_check(@ingredient2)).to eq 7
    end

    it 'can determine if there are enough ingredients for the recipe' do
        @recipe1 = Recipe.new("Mac and Cheese")
        @recipe2 = Recipe.new("Cheese Burger")

        @recipe1.add_ingredient(@ingredient1, 2)
        @recipe1.add_ingredient(@ingredient2, 8)

        @recipe2.add_ingredient(@ingredient1, 2)
        @recipe2.add_ingredient(@ingredient3, 4)
        @recipe2.add_ingredient(@ingredient4, 1)

        @pantry.restock(@ingredient1, 5)
        @pantry.restock(@ingredient1, 10)

        expect(@pantry.enough_ingredients_for?(@recipe1)).to eq false

        @pantry.restock(@ingredient2, 7)

        expect(@pantry.enough_ingredients_for?(@recipe1)).to eq false

        @pantry.restock(@ingredient2, 1)

        expect(@pantry.enough_ingredients_for?(@recipe1)).to eq true
    end
end