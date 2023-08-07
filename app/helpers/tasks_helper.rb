module TasksHelper
  def get_priority(task)
    Priority.find(task.priority_id)
  end
end
