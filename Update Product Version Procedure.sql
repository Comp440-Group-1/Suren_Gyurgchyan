

-- Procedure to update product version in the release table
CREATE PROCEDURE sp_update_version
(
@product_id INT,
@release_id INT,
@version VARCHAR(50)

)
AS
IF EXISTS(SELECT * FROM release WHERE product_id = @product_id) -- checks to see if Product ID exists in the Release tabley
    BEGIN
        UPDATE release
        SET version = @version
        WHERE product_id = @product_id
        AND release_id = @release_id;
    END
ELSE
    BEGIN
        RAISERROR('Product ID doesn''t exist in the Database. Please select a valid Product ID!', 16, 1); --if the ID doesn't exist we raise an error message.
        RETURN;
    END

GO