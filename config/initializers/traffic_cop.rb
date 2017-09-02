require "connection_pool"

# The amazon product advertising API rate limits us pretty hard
# So we need the connection_pool and redis to count our req/s
# And the trafic control will re-schedule jobs
ActiveJob::TrafficControl.client = ConnectionPool.new(size: 5, timeout: 5) { Redis.new }
