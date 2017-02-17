class Task

  def initialize(title, description)
    @title=title
    @description=description
    @done=false
  end

  def title
    @title
  end

  def description
    @description
  end

  def done
    @done
  end

  def mark
    if @done == false
      @done = true
    else
      @done = false
    end
  end

  def to_s
      "Title: #{@title} -- Description: #{@description}"
  end

end

#<FirstClass> is-a <SecondClass> means that FirstClass inherets from Second class, ie. FirstClass < SecondClass

class DueDateTask < Task

  def initialize (title, description, date)
    super(title, description)
    @due_date = date
  end

  def due_date
    @due_date
  end

  def to_s
    "Due Date: #{@due_date.mon}-#{@due_date.mday}-#{@due_date.year} -- " + super
  end

end

class Anniversary < DueDateTask

  def to_s
    "Anniversary: #{due_date} -- Title: #{title} -- Description: #{description}"
  end

end

class TaskList

# <FirstClass> has-many <SecondClass = The first class should have an array that will eventually contain many objects of the second class

  def initialize
    @task_list = []
  end

  def store task
    @task_list << task
  end

  def task_list
    @task_list
  end

  def getCompletedItems
    @task_list.select { |t|
      t.done==true
    }
  end

  def getIncompleteItems
    @task_list.select { |t|
      t.done==false
    }
  end

  def getIncompleteItemsDueToday
    @task_list.select { |t|
      t.done==false &&  #get all incomplete tasks
      t.class == DueDateTask && (t.due_date.mday==Date.today.mday && t.due_date.mon==Date.today.mon &&
      t.due_date.year==Date.today.year)
    }
  end

  def getIncompleteItemsByDate
    #First, I make an array that contains all the DueDateTasks in @task_list
    onlyDueDates = @task_list.select { |t|
      t.class == DueDateTask
    }
    # @task_list[Task.new("New Task", ""), DueDateTask.new("New", "Due", "Date")]

    #Then I create an array that contains all the Tasks in task list
    onlyNormalTasks = @task_list.select { |t|
      t.class == Task
    }

    onlyDueDates.sort{|task1, task2|
      task1.due_date <=> task2.due_date
    } + onlyNormalTasks
  end

  def getIncompleteItemsInMonth

    onlyDatesInMonth = @task_list.select { |t|
      (t.class == Anniversary || (t.class == DueDateTask && t.due_date.year==Date.today.year) && t.due_date.mon==Date.today.mon)
    }
    # @task_list[Task.new("New Task", ""), DueDateTask.new("New", "Due", "Date")]

    #Then I create an array that contains all the Tasks in task list
    onlyNormalTasks = @task_list.select { |t|
      t.class == Task
    }

    onlyDatesInMonth.sort{|task1, task2|
      task1.due_date <=> task2.due_date
    } + onlyNormalTasks
  end

end

# arr = [Array.new(5).fill(0), Array.new(5).fill(0), Array.new(5).fill(0), Array.new(5).fill(0),Array.new(5).fill(0)]
# #some bullshit
# arr.each { |a|
#   a.each { |i|
#     print i
#   }
#   puts
# }
