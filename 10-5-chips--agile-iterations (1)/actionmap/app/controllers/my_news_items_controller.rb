# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issue_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def new_page2
    issue = @issue_list[params[:issue_id].to_i]
    api_key = 'd2aea7a2ca68402d91cba204856fcfd0'
    representative_name = @representative.name.to_s

    uri = URI("https://newsapi.org/v2/everything?q=#{representative_name}+#{issue}&apiKey=#{api_key}&pageSize=5")
    response = Net::HTTP.get(uri)

    articles = JSON.parse(response)['articles']

    @articles = articles.map do |article|
      {
        title:       article['title'],
        url:         article['url'],
        description: article['description']
      }
    end
  end

  def new_article
    selected_article = params[:selected_article]
    rating = params[:rating].to_i

    @news_item = @representative.news_items.create(
      title:       selected_article[:title],
      link:        selected_article[:url],
      description: selected_article[:description],
      rating:      rating,
      issue:       params[:issue]
    )

    @news_item.save
    redirect_to representative_news_items_path(@representative)
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id)
  end

  def set_issue_list
    @issue_list = [
      'Free Speech', 'Immigration', 'Terrorism',
      'Social Security and Medicare', 'Abortion',
      'Student Loans', 'Gun Control', 'Unemployment',
      'Climate Change', 'Homelessness', 'Racism',
      'Tax Reform', 'Net Neutrality', 'Religious Freedom',
      'Border Security', 'Minimum Wage', 'Equal Pay'
    ]
  end
end
