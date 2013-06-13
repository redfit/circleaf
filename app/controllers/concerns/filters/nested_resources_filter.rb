class Filters::NestedResourcesFilter
  def before(c)
    request = c.request
    if request.path =~ /\/([^\/]*)\/[0-9]+\/#{c.controller_name}/
      begin
        resources = $1
        parent_model = resources.classify.constantize
        parent_id = c.params["#{resources.singularize}_id"]
        c.instance_eval do
          @parent = parent_model.find parent_id
        end
      end
    end
  end
end
