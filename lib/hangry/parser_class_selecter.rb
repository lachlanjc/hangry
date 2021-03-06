require 'hangry/recipe_parser'
require 'hangry/default_recipe_parser'
require 'hangry/hrecipe_parser'
require 'hangry/schema_org_recipe_parser'
require 'hangry/data_vocabulary_recipe_parser'
require 'hangry/parsers/non_standard/all_recipes_parser'
require 'hangry/parsers/non_standard/eating_well_parser'
require 'hangry/parsers/non_standard/taste_of_home_parser'

module Hangry
  class ParserClassSelecter
    def initialize(html)
      @html = html
    end

    def parser_class
      # Prefer the more specific parsers
      parser_classes = [
        Parsers::NonStandard::AllRecipesParser,
        Parsers::NonStandard::EatingWellParser,
        Parsers::NonStandard::TasteOfHomeParser
      ]
      parser_classes += [SchemaOrgRecipeParser, HRecipeParser, DataVocabularyRecipeParser]
      parser_classes << DefaultRecipeParser
      parser_classes.detect { |p| p.can_parse?(@html) }
    end
    
  end
end
