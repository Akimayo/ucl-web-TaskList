class List
    include ActiveModel::Model

    attr_accessor :search, :categories, :tags, :order_by, :order_direction, :group_by, :is_done

    def initialize
        super
        @empty = true
    end

    def filter(params, user, page = 1)
        @group_by = !params.nil? && params[:group_by] == "1"

        if @group_by then categories = user.categories.all.includes(tasks: [:tag_associations, :tags])
        else tasks = user.tasks.all.includes(:category, :tag_associations, :tags) end

        unless params.nil?
            @empty = false
            @search = params[:search]
            @categories = params[:categories]
            @tags = params[:tags]
            @order_by = params[:order_by]
            @order_direction = params[:order_direction]
            @is_done = (!params[:is_done].nil? && params[:is_done].count > 1) ? params[:is_done][1] : nil

            if @group_by
                # Highly non-ideal solution, wold deserve some love
                # Ideally, this would call only new(), so not writing to databse, but that doesn't seem to work
                #   (Basically creates a new category, fills it with tasks that don't belong to one, and deletes it after render)
                #   (Like, honestly, this is a bad idea, it works on human amounts of tasks, but on 400, not even the assignment really holds up, this takes ages)
                # tasks.create(id: -1, title: "Nezařazené", color: "#FFFFFF", tasks: user.tasks.where(category_id: nil))
                # Bullet will yell about avoiding eager loading because of loaded tasks on above line
                tasks = {collection: categories.order(title: "ASC"), ungrouped: user.tasks.where(category_id: nil).includes(:category, :tag_associations, :tags)}
            else
                tasks.where!("title LIKE ? OR note LIKE ?", "%#{@search}%", "%#{@search}%") if !@search.nil? && @search.length > 0
                tasks.where!(category_id: @categories) if !@categories.nil? && @categories.count > 1
                tasks.where!("tag_associations.tag_id": @tags) if !@tags.nil? && @tags.count > 1
                tasks.where!(is_done: @is_done == "true" ? true : false) unless @is_done.nil?
                tasks.order!("deadline_at IS NOT NULL DESC") if !@order_by.nil? && @order_by.length > 0
                tasks.order!("#{@order_by} #{@order_direction}") unless @order_by.nil? || @order_by == ""
            end
        end
        return tasks
    end

    def empty?
        return @empty
    end
    def sorted?
        return @group_by || !@order_by.nil? && @order_by.length > 0
    end
    def filter_count
        fts = 0
        fts += 1 if !@search.nil? && @search.length > 0
        fts += 1 if !@categories.nil? && @categories.count > 1
        fts += 1 if !@tags.nil? && @tags.count > 1
        fts += 1 unless @is_done.nil?
        return fts
    end
end