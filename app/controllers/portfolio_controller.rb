class PortfolioController < ApplicationController
	layout 'application'

	before_filter :setSlideItem

	def index
	end

	def search
	end

	def setSlideItem
		@curSlideItem = 'find'
	end
end
