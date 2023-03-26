-- Trigger 1 doesn't let the customer add more than quantity available 
DELIMITER $$
CREATE TRIGGER trg_check_quantity
BEFORE INSERT ON ShoppingCart
FOR EACH ROW
BEGIN
    DECLARE available_quantity INT;
    SELECT quantity INTO available_quantity FROM Product WHERE product_id = NEW.product_id;
    IF NEW.quantity > available_quantity THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot add more than available quantity';
    END IF;
END$$
DELIMITER ;


-- Trigger 2 that sets the default rating of any new product added to zero
DELIMITER //

CREATE TRIGGER set_default_rating 
BEFORE INSERT ON Product
FOR EACH ROW 
BEGIN
	SET NEW.rating = 0;
END //

DELIMITER ;





