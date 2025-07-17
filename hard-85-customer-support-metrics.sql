-- You are working for a customer support team at an e-commerce company. The company provides customer support through both web-based chat and mobile app chat. Each conversation between a customer and a support agent is logged in a database table named conversation. The table contains information about the sender (customer or agent), the message content, the order related to the conversation, and other relevant details.
-- Your task is to analyze the conversation data to extract meaningful insights for improving customer support efficiency. Write an SQL query to fetch the following information from the conversation table for each order_id and sort the output by order_id.

-- order_id: The unique identifier of the order related to the conversation.
-- city_code: The city code where the conversation took place. This is unique to each order_id.
-- first_agent_message: The timestamp of the first message sent by a support agent in the conversation.
-- first_customer_message: The timestamp of the first message sent by a customer in the conversation.
-- num_messages_agent: The total number of messages sent by the support agent in the conversation.
-- num_messages_customer: The total number of messages sent by the customer in the conversation.
-- first_message_by: Indicates whether the first message in the conversation was sent by a support agent or a customer.
-- resolved(0 or 1): Indicates whether the conversation has a message marked as resolution = true, atleast once.
-- reassigned(0 or 1): Indicates whether the conversation has had interactions by more than one support agent.
/*
Table: conversation 
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| senderDeviceType | varchar(20) |
| customerId       | int         |
| orderId          | varchar(10) |
| resolution       | varchar(10) |
| agentId          | int         |
| messageSentTime  | datetime    |
| cityCode         | varchar(6) |
+------------------+-------------+
*/


select orderId, cityCode,
min(case when senderDeviceType = 'Web Agent' then messageSentTime end) as first_agent_message,
min(case when senderDeviceType = 'Android Customer' then messageSentTime end) as first_customer_message,
sum(case when senderDeviceType = 'Web Agent' then 1 else 0 end) as num_messages_agent,
sum(case when senderDeviceType = 'Android Customer' then 1 else 0 end) as num_messages_customer,
case when min(messageSentTime) = min(case when senderDeviceType = 'Web Agent' then messageSentTime end) then 'Agent'
when min(messageSentTime) = min(case when senderDeviceType = 'Android Customer' then messageSentTime end) then 'Customer' end as first_message_by,
sum(case when resolution = 'True' then 1 else 0 end) as resolved,
case when count(distinct agentId) > 1 then 1 else 0 end as reassigned 
from conversation
group by orderId, cityCode

