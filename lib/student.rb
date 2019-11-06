#Write a method that drops that table

class Student
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name = nil, grade = nil)
    @name = name
    @grade = grade
  end
  
  #Write a method that drops that table
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        );
      SQL
      DB[:conn].execute(sql)
  end


  #Write a method that drops that table
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end


 #Write a method that saves a given instance to the database table.
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid()
    FROM students")[0][0]
  end

  #Write a method that both creates a new instance of the class and saves that instance to a database table.
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
