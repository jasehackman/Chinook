-- #1

SELECT FirstName, LastName, CustomerId, Country
FROM Customer;


--  #2 brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT * From Customer
Where Country = "Brazil";
-- #3 brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
Select c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
From Invoice i
LEFT JOIN Customer c
ON i.CustomerId = c.CustomerId
Where c.Country = "Brazil";

-- Select c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
-- From Customer c
-- LEFT JOIN Invoice i
-- ON i.CustomerId = c.CustomerId
-- Where c.Country = "Brazil";

-- #4 sales_agents.sql: Provide a query showing only the Employees
--  who are Sales Agents.
Select *
From Employee
Where Title like "Sales%";
-- #5 unique_invoice_countries.sql: Provide a query showing a
-- unique/distinct list of billing countries from the Invoice table.

Select distinct BillingCountry
From Invoice;

-- #6 sales_agent_invoices.sql: Provide a query that shows the
-- invoices associated with each sales agent. The resultant table
-- should include the Sales Agent's full name.
Select e.FirstName, e.LastName, i.*
From Customer c
Left Join Employee e
on e.EmployeeId = c.SupportRepId
Left Join Invoice i
on i.CustomerId = c.CustomerId;

-- #7 invoice_totals.sql: Provide a query that shows the Invoice Total,
-- Customer name, Country and Sale Agent name for all invoices and
-- customers.

Select e.FirstName, e.LastName, i.Total, c.FirstName as CustomerFirstName, c.LastName as CustomerLastName, i.BillingCountry
From Customer c
Left Join Employee e
on e.EmployeeId = c.SupportRepId
Left Join Invoice i
on i.CustomerId = c.CustomerId;

-- #8 total_invoices_{year}.sql: How many Invoices were there in
-- 2009 and 2011?

Select Count(InvoiceDate)
From Invoice
Where InvoiceDate Between "2009-01-01" and "2011-12-31";

Select Count(InvoiceDate)
From Invoice
Where InvoiceDate like "2009%"
or InvoiceDate like "2011%"

-- #9 total_sales_{year}.sql: What are the respective total sales for
-- each of those years?
Select Count(InvoiceDate) as 2009
From Invoice
Where InvoiceDate like "2009%"

Select Count(InvoiceDate) as 2011
From Invoice
Where InvoiceDate like "2011%"


-- #10 invoice_37_line_item_count.sql: Looking at the InvoiceLine table,
-- provide a query that COUNTs the number of line items for Invoice ID 37.
Select count(*)
From InvoiceLine
Where InvoiceId = "37";
-- #11 line_items_per_invoice.sql: Looking at the InvoiceLine table,
-- provide a query that COUNTs the number of line items for each Invoice.
-- HINT: GROUP BY

Select count(*), InvoiceId
From InvoiceLine
Group by InvoiceId;

-- #12 line_item_track.sql: Provide a query that includes the
-- purchased track name with each invoice line item.
Select InvoiceLine.*, Track.name
From InvoiceLine
Join Track
on InvoiceLine.TrackId = Track.TrackId;
-- #13 line_item_track_artist.sql: Provide a query that includes the
-- purchased track name AND artist name with each invoice line item.
Select i.*, t.name as "Track Name", Artist.Name as "Artist Name"
From InvoiceLine i
Join Track t
on i.TrackId = t.TrackId
Join Album
on Album.AlbumId = t.AlbumId
Join Artist
on Artist.ArtistId = Album.ArtistId;

-- #14 country_invoices.sql: Provide a query that shows the # of
-- invoices per country. HINT: GROUP BY

Select count(*), BillingCountry
From Invoice
Group By BillingCountry;

-- #15 playlists_track_count.sql: Provide a query that shows the
-- total number of tracks in each playlist. The Playlist name should
-- be include on the resulant table.

Select Playlist.Name, count(PlaylistTrack.TrackId)
From Playlist
Join PlaylistTrack
on Playlist.PlaylistId = PlaylistTrack.PlaylistId
Group By Playlist.Name;

-- #16 tracks_no_id.sql: Provide a query that shows all the Tracks,
-- but displays no IDs. The result should include the Album name,
-- Media type and Genre.

Select t.Name as "Track Name", a.Title as "Album Title",
m.Name as "Media Type", g.Name as"Genre"
From Track t
Join Album a
on a.AlbumId = t.AlbumId
Join MediaType m
on m.MediaTypeId = t.MediaTypeId
Join Genre g
On g.GenreId = t.GenreId;


-- #17 invoices_line_item_count.sql: Provide a query that shows all
-- Invoices but includes the # of invoice line items.
Select i.*, count(InvoiceLine.InvoiceLineId)
From Invoice i
Join InvoiceLine
on i.InvoiceId = InvoiceLine.InvoiceId
Group By i.InvoiceId;

-- #18 sales_agent_total_sales.sql: Provide a query that shows
-- total sales made by each sales agent.

Select e.FirstName, e.LastName, e.Title, count(i.InvoiceId) as "Total Sales"
From Employee e
Join Customer c
on c.SupportRepId = e.EmployeeId
Join Invoice i
on c.CustomerId = i.CustomerId
Where e.Title like "Sales%"
Group By e.FirstName;

-- #19 top_2009_agent.sql: Which sales agent made the most in sales
-- in 2009?

        -- Hint: Use the MAX function on a subquery.

Select "Name", max(Total)
From
(Select e.FirstName || " " || e.LastName as "Name", sum(i.total) as "Total"
From Employee e
Join Customer c
on c.SupportRepId = e.EmployeeId
Join Invoice i
on c.CustomerId = i.CustomerId
Where i.InvoiceDate like "2009%"
Group By e.FirstName);


-- #20 top_agent.sql: Which sales agent made the most in sales over all?
Select "Name", max(Total)
From
(Select e.FirstName || " " || e.LastName as "Name", sum(i.total) as "Total"
From Employee e
Join Customer c
on c.SupportRepId = e.EmployeeId
Join Invoice i
on c.CustomerId = i.CustomerId
Group By e.FirstName);
-- #21 sales_agent_customer_count.sql: Provide a query that shows the
-- count of customers assigned to each sales agent.

Select e.FirstName || " " || e.LastName as "Name", count(Customer.CustomerId) as "Customer Count"
From Employee e
Join Customer
on Customer.SupportRepId = e.EmployeeId
Group By e.FirstName;

-- #22 sales_per_country.sql: Provide a query that shows the total sales
-- per country.

Select i.BillingCountry, count(i.InvoiceId) as "Total"
From Invoice i
Group By i.BillingCountry;

-- #23 top_country.sql: Which country's customers spent the most?

Select i.BillingCountry, count(i.InvoiceId) as "Total"
From Invoice i
Group By i.BillingCountry;

-- #24 top_2013_track.sql: Provide a query that shows the most purchased
--  track of 2013.

Select TrackName, max("count")
From (
Select t.Name as "TrackName", count(il.TrackId) as "count"
From Track t
Join InvoiceLine il
on t.TrackId = il.TrackId
Join Invoice
on Invoice.InvoiceId = il.InvoiceId
where Invoice.InvoiceDate like "2013%"
Group By t.Name);

-- #25 top_5_tracks.sql: Provide a query that shows the top 5 most
-- purchased tracks over all.

Select TrackName, "count"
From (
Select t.Name as "TrackName", count(il.TrackId) as "count"
From Track t
Join InvoiceLine il
on t.TrackId = il.TrackId
Join Invoice
on Invoice.InvoiceId = il.InvoiceId
Group By t.Name)
Order By "count" DESC
Limit 5;

-- #26 top_3_artists.sql: Provide a query that shows the top 3 best
-- selling artists.

Select a.Name as "Artist", count(il.InvoiceLineId) as "count"
From Artist a
Join Album al
on a.ArtistId = al.ArtistId
Join Track t
on al.AlbumId = t.AlbumId
Join InvoiceLine il
on il.TrackId = t.TrackId
Group By a.Name
Order by "count" DESC
Limit 3;

-- #27 top_media_type.sql: Provide a query that shows the most purchased
--  Media Type.

Select m.Name, count(t.MediaTypeId) as "count"
From MediaType m
Join Track t
on m.MediaTypeId = t.MediaTypeId
Group By m.Name
Order by "count" DESC
Limit 1;