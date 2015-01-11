require "database_error_handler/version"

module DatabaseErrorHandler
  extend ActiveSupport::Concern

  included do
    extend DatabaseErrorHandler
  end

  def handle_duplicate_entry(idempotent: false)
    yield
  rescue Mysql2::Error, ActiveRecord::StatementInvalid => e
    if e.message =~ /Duplicate entry/
      retry if idempotent
    else
      raise e
    end
  end

  def handle_db_errors(retry_count: 3)
    ActiveRecord::Base.transaction do
      yield
    end

  rescue ActiveRecord::ConnectionTimeoutError => e
    retry if (retry_count -= 1) > 0
    raise e

  rescue ActiveRecord::StatementInvalid => e
    # mysql2 errors are wrapped into ActiveRecord::StatementInvalid
    case e.message
    when /Duplicate entry/
      # do nothing

    when /Deadlock/, /Lock wait timeout exceeded/
      retry if (retry_count -= 1) > 0
    else
      raise e
    end

    false
  end
end

ActiveRecord::Base.include DatabaseErrorHandler
