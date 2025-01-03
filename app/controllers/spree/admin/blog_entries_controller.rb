class Spree::Admin::BlogEntriesController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  before_action :init_pagination, :only => [:index]

  def index
    params[:q] ||= {}

    @search = Spree::BlogEntry.visible.page(@pagination_page).per(@pagination_per_page).ransack(params[:q])
    @blog_entries = @search.result(distinct: true)
  end

  private

  def location_after_save
    edit_admin_blog_entry_url(@blog_entry)
  end

  def collection
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
    model_class.page(page).per(per_page)
  end

  def init_pagination
    @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 12
  end
end
