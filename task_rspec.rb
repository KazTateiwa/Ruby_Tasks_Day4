require 'rspec'
require_relative 'tasks'

# Story: As a developer, I can create a Task.

describe Task do
  it "can create a Task object" do
    expect{Task.new("","")}.to_not raise_error
  end

  # Story: As a developer, I can give a Task a title and retrieve it.

  it "has a title" do
    expect(Task.new("New Task", "").title).to eq("New Task")
  end

  # Story: As a developer, I can give a Task a description and retrieve it.

  it "has a description" do
    expect(Task.new("", "No description").description).to eq("No description")
  end

  # Story: As a developer, I can mark a Task done.

  it "has a done variable" do
    expect(Task.new("","").done).to eq(false)
  end

  it "has a mark function" do
    expect(Task.new("","").mark).to eq(true)
  end

  #Story: As a developer, when I print a Task that is done, its status is shown. Hint: Implement to_s have it return the features of a Task with labels (for instance, "Title: Buy Food Description: Bananas, milk").

  it "prints the status, only if it is done" do
    expect(Task.new("New Task", "No description").to_s).to eq("Title: New Task -- Description: No description")
  end

end

describe TaskList do

  #Story: As a developer, I can add all of my Tasks to a TaskList.

  it "can add all of my Tasks to a TaskList" do
    tl = TaskList.new
    task = Task.new("Task1", "hHe first task")
    tl.store task
    tl.store Task.new("Task2", "The second task")
    puts tl.task_list
    expect(tl.task_list).to include(task)
  end

  # Story: As a developer with a TaskList, I can get the completed items

  it "can get a list with the completed items" do
    tl = TaskList.new
    task = Task.new("Task1", "The first task")
    task.mark
    tl.store task
    tl.store Task.new("Task2", "The second task")
    expect(tl.getCompletedItems).to include(task)
  end

  it "can add DueDateTasks to our TaskList" do
    tl = TaskList.new
    task = Task.new("Task1", "The first task")
    taskDue = DueDateTask.new("DueDate", "A new due date task", Date.new(2001,11,11))
    tl.store task
    tl.store taskDue
    puts "Array ------------"
    puts tl.task_list
    puts "-------------- End Array"
    expect(tl.task_list).to include(taskDue)
  end


  # Story: As a developer with a TaskList, I can list all the not completed items that are due today.

  it "can return only tasks that are due today" do
    tl = TaskList.new
    task1 = DueDateTask.new("Task1", "First task", Date.new(2017,2,16))
    task2 = DueDateTask.new("Task2", "Second task", Date.new(1999,1,31))
    tl.store task1
    tl.store task2
    expect(tl.getIncompleteItemsDueToday).to include(task1)
  end

  # Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.

  it "can list all the not completed items in order of due date and then not due date" do
    tl = TaskList.new
    task1 = DueDateTask.new("Task1", "First task", Date.new(2017,2,16))
    task2 = DueDateTask.new("Task2", "Second task", Date.new(1999,1,31))
    task3 = Task.new("PLaceholder", "p")
    task4 = Task.new("", "")
    tl.store task1
    tl.store task2
    tl.store task3
    tl.store task4
    expect(tl.getIncompleteItemsByDate[0]).to eq(task2)
  end

  # Story: As a developer with a TaskList with and without due dates and yearly recurring dates, I can list all the not completed items in order of due date and yearly dates for the current month.

  it "can create an ordered list of due dates and Anniversaries for the current month" do
    tl = TaskList.new
    task1 = Task.new("BLAH", "blah")
    task2 = DueDateTask.new("Same Month", "What a month", Date.new(2017,2,9))
    dueTask1 = DueDateTask.new("BLAH", "blah", Date.new(1999,2,17))
    anniversary1 = Anniversary.new("Ann", "Iversary", Date.new(2017,2,17))
    tl.store task1
    tl.store task2
    tl.store dueTask1
    tl.store anniversary1
    #tl.task_list => task1, dueTask1, and anniversary
    puts tl.getIncompleteItemsInMonth
    expect(tl.getIncompleteItemsInMonth[1]).to eq(anniversary1)
  end
end

describe DueDateTask do
  it "can create a DueDateTask object" do
    expect{DueDateTask.new("DueDate", "A new Due Date", Date.new(2017,2,17))}.to_not raise_error
  end

  # Story: As a developer, I can print an item with a due date with labels and values.

  it "can print an item with a due date, title, and description" do
    expect(DueDateTask.new("DueDate", "A new Due Date", Date.new(2017,2,17)).to_s).to eq("Due Date: 2-17-2017 -- Title: DueDate -- Description: A new Due Date")
  end
end

describe Anniversary do
  it "can create an Anniversary object" do
    expect{Anniversary.new("Dad's Bday", "blah blah", Date.new(1111,11,11))}.to_not raise_error
  end

  it "has a custom to_s method" do
    expect(Anniversary.new("Dad's Bday", "blah blah", Date.new(1111,11,11)).to_s).to eq("Anniversary: 1111-11-11 -- Title: Dad's Bday -- Description: blah blah")
  end
end
