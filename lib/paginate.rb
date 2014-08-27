module PaginateHelper

  def paginate(postnumber, page)
    page = { 0 }
    postnumber = {@topics.post}

    postnumber.limit(10).offset(page * 10)

    postnumber.limit(10).offset(page * 10) do |relation_of_ten|
      do_something_with(relation_of_ten)
    end

  end