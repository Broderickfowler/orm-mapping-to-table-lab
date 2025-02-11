class Student
  attr_reader :id
  attr_accessor :name, :grade
  
  def initialize(name=nil, grade=nil)
    @name = name
    @grade = grade
   end
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    
    DB[:conn].execute('DROP TABLE IF EXISTS students ') 
  end
  
  def save
    sql = <<-SQL "INSERT INTO students (name, grade) VALUES (?,?)"
    
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  
  end
  
def self.create(attributes)
    student = Student.new
    attributes.each{|key, value|
      student.send(("#{key}="), value)
    }
    student.save
    student 
  end
  
  
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
