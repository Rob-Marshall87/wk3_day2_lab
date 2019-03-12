require('pg')

class Bounty
  attr_accessor :name, :species, :bounty_value, :danger_level
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
  end

  def save()
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "INSERT INTO bounties (name, species, bounty_value, danger_level) VALUES ($1, $2, $3, $4) RETURNING *;"

    values = [@name, @species, @bounty_value, @danger_level]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i

    db.close()
  end

  def update()
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "UPDATE bounties SET (name, species, bounty_value, danger_level) = ($1, $2, $3, $4) WHERE id = $5;"

    values = [@name, @species, @bounty_value, @danger_level, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Bounty.delete_all()
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "DELETE FROM bounties;"
    db.prepare("delete", sql)
    db.exec_prepared("delete")
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "SELECT * FROM bounties WHERE name = $1;"

    values = [name]

    db.prepare("find", sql)
    found_name = db.exec_prepared("find", values).to_a
    db.close()
    # found_name.map {|hash| Bounty.new(hash)}
    if found_name.empty?
      return nil
    else
      return found_name
    end
    # return found_name

  end


  def Bounty.find_by_id(id)
    db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'} )
    sql = "SELECT * FROM bounties WHERE id = $1;"

    values = [id]

    db.prepare("find", sql)
    found_id = db.exec_prepared("find", values).to_a
    db.close()
    return found_id
  end

end
