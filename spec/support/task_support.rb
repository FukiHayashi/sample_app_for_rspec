module TaskSupport
  def fill_task_form_info(task, deadline)
    fill_form_info(task)
    fill_in 'Deadline', with: deadline
    find_button('Create Task').click
  end

  def fill_edit_task_form_info(task)
    fill_form_info(task)
    find_button('Update Task').click
  end

  private

  def fill_form_info(task)
    fill_in 'Title', with: task.title
    fill_in 'Content', with: task.content
    select task.status, from: 'Status'
  end
end

RSpec.configure do |config|
  config.include TaskSupport
end
