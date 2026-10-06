from flask import Flask, render_template, jsonify, request, redirect
from db import get_db_connection

app = Flask(
    __name__,
    template_folder="../frontend/templates",
    static_folder="../frontend/static",
    static_url_path="/static"
)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/api/test-db")
def test_db():
    try:
        db = get_db_connection()
        cursor = db.cursor()

        cursor.execute("SELECT COUNT(*) FROM package")
        package_count = cursor.fetchone()[0]

        cursor.close()
        db.close()

        return jsonify({
            "status": "success",
            "message": "MySQL connection successful",
            "database": "tourism_booking_db",
            "package_count": package_count
        })

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 500
@app.route("/packages")
def packages():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    try:
        cursor.execute("SELECT * FROM package")
        packages = cursor.fetchall()

        cursor.close()
        db.close()

        return render_template("packages.html", packages=packages)

    except Exception as e:
        cursor.close()
        db.close()
        return f"Error loading packages: {e}", 500

@app.route("/package/<int:package_id>")
def package_details(package_id):
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    query = """
        SELECT
            p.package_id,
            p.package_name,
            p.duration_days,
            p.base_price,
            p.max_travelers,
            p.description,
            d.destination_name,
            d.city,
            d.state,
            d.country,
            h.hotel_name,
            h.star_rating,
            h.room_price,
            t.transport_type,
            t.provider_name,
            t.source,
            t.destination AS transport_destination,
            t.price AS transport_price
        FROM package p
        LEFT JOIN package_destination pd
            ON p.package_id = pd.package_id
        LEFT JOIN destination d
            ON pd.destination_id = d.destination_id
        LEFT JOIN package_hotel ph
            ON p.package_id = ph.package_id
        LEFT JOIN hotel h
            ON ph.hotel_id = h.hotel_id
        LEFT JOIN package_transport pt
            ON p.package_id = pt.package_id
        LEFT JOIN transport t
            ON pt.transport_id = t.transport_id
        WHERE p.package_id = %s
    """

    cursor.execute(query, (package_id,))
    package = cursor.fetchone()

    cursor.close()
    db.close()

    if not package:
        return "Package not found", 404

    return render_template("package.html", package=package)

@app.route("/book/<int:package_id>", methods=["GET", "POST"])
def book_package(package_id):
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM package WHERE package_id = %s",
        (package_id,)
    )
    package = cursor.fetchone()

    if not package:
        cursor.close()
        db.close()
        return "Package not found", 404

    if request.method == "POST":
        full_name = request.form["full_name"]
        email = request.form["email"]
        phone = request.form["phone"]
        gender = request.form["gender"]
        date_of_birth = request.form["date_of_birth"]
        travel_date = request.form["travel_date"]
        number_of_travelers = int(request.form["number_of_travelers"])

        total_amount = package["base_price"] * number_of_travelers

        try:
            cursor.execute(
                """
                SELECT customer_id
                FROM customer
                WHERE email = %s OR phone = %s
                """,
                (email, phone)
            )

            existing_customer = cursor.fetchone()

            if existing_customer:
                customer_id = existing_customer["customer_id"]
            else:
                cursor.execute(
                    """
                    INSERT INTO customer
                    (full_name, email, phone, gender, date_of_birth)
                    VALUES (%s, %s, %s, %s, %s)
                    """,
                    (
                        full_name,
                        email,
                        phone,
                        gender,
                        date_of_birth
                    )
                )

                customer_id = cursor.lastrowid

            cursor.execute(
                """
                INSERT INTO booking
                (
                    customer_id,
                    package_id,
                    booking_date,
                    travel_date,
                    number_of_travelers,
                    total_amount,
                    booking_status
                )
                VALUES
                (
                    %s,
                    %s,
                    CURDATE(),
                    %s,
                    %s,
                    %s,
                    'Pending'
                )
                """,
                (
                    customer_id,
                    package_id,
                    travel_date,
                    number_of_travelers,
                    total_amount
                )
            )

            booking_id = cursor.lastrowid

            db.commit()

            cursor.close()
            db.close()

            return redirect(f"/payment/{booking_id}")

        except Exception as e:
            db.rollback()
            cursor.close()
            db.close()

            return render_template(
                "booking.html",
                package=package,
                error=str(e)
            )

    cursor.close()
    db.close()

    return render_template(
        "booking.html",
        package=package
    )


@app.route("/payment/<int:booking_id>", methods=["GET", "POST"])
def payment(booking_id):
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            b.booking_id,
            b.package_id,
            b.number_of_travelers,
            b.total_amount,
            p.package_name
        FROM booking b
        JOIN package p ON b.package_id = p.package_id
        WHERE b.booking_id = %s
    """, (booking_id,))

    booking = cursor.fetchone()

    if not booking:
        cursor.close()
        db.close()
        return "Booking not found", 404

    if request.method == "POST":
        payment_method = request.form["payment_method"]

        transaction_id = "TXN" + str(booking_id) + str(int(__import__("time").time()))[-8:]

        try:
            cursor.execute("""
                INSERT INTO payment
                (booking_id, transaction_id, payment_date, amount,
                 payment_method, payment_status)
                VALUES (%s, %s, CURDATE(), %s, %s, 'Successful')
            """, (
                booking_id,
                transaction_id,
                booking["total_amount"],
                payment_method
            ))

            cursor.execute("""
                UPDATE booking
                SET booking_status = 'Confirmed'
                WHERE booking_id = %s
            """, (booking_id,))

            db.commit()

            cursor.close()
            db.close()

            return render_template(
                "payment_success.html",
                booking=booking,
                transaction_id=transaction_id,
                payment_method=payment_method
            )

        except Exception as e:
            db.rollback()
            cursor.close()
            db.close()
            return render_template(
                "payment.html",
                booking=booking,
                error=str(e)
            )

    cursor.close()
    db.close()

    return render_template("payment.html", booking=booking)


@app.route("/admin")
def admin_dashboard():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT COUNT(*) AS total FROM customer")
    total_customers = cursor.fetchone()["total"]

    cursor.execute("SELECT COUNT(*) AS total FROM package")
    total_packages = cursor.fetchone()["total"]

    cursor.execute("SELECT COUNT(*) AS total FROM booking")
    total_bookings = cursor.fetchone()["total"]

    cursor.execute("""
        SELECT COALESCE(SUM(total_amount), 0) AS total
        FROM booking
        WHERE booking_status != 'Cancelled'
    """)
    total_revenue = cursor.fetchone()["total"]

    cursor.execute("""
        SELECT
            b.booking_id,
            c.full_name,
            p.package_name,
            b.number_of_travelers,
            b.travel_date,
            b.total_amount,
            b.booking_status
        FROM booking b
        JOIN customer c
            ON b.customer_id = c.customer_id
        JOIN package p
            ON b.package_id = p.package_id
        ORDER BY b.booking_id DESC
        LIMIT 10
    """)
    recent_bookings = cursor.fetchall()

    cursor.close()

    return render_template(
        "admin.html",
        total_customers=total_customers,
        total_packages=total_packages,
        total_bookings=total_bookings,
        total_revenue=total_revenue,
        recent_bookings=recent_bookings
    )


@app.route("/customers")
def customers():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            customer_id,
            full_name,
            email,
            phone,
            gender,
            date_of_birth
        FROM customer
        ORDER BY customer_id DESC
    """)

    customers = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template("customers.html", customers=customers)


@app.route("/customers/add", methods=["GET", "POST"])
def add_customer():
    if request.method == "POST":
        full_name = request.form["full_name"]
        email = request.form["email"]
        phone = request.form["phone"]
        gender = request.form["gender"]
        date_of_birth = request.form["date_of_birth"]

        db = get_db_connection()
        cursor = db.cursor()

        try:
            cursor.execute("""
                INSERT INTO customer
                (full_name, email, phone, gender, date_of_birth)
                VALUES (%s, %s, %s, %s, %s)
            """, (
                full_name,
                email,
                phone,
                gender,
                date_of_birth
            ))

            db.commit()
            cursor.close()
            db.close()

            return redirect("/customers")

        except Exception as e:
            db.rollback()
            cursor.close()
            db.close()
            return f"Error adding customer: {e}", 500

    return render_template("add_customer.html")


@app.route("/customers/delete/<int:customer_id>", methods=["POST"])
def delete_customer(customer_id):
    db = get_db_connection()
    cursor = db.cursor()

    try:
        cursor.execute(
            "DELETE FROM customer WHERE customer_id = %s",
            (customer_id,)
        )
        db.commit()

        cursor.close()
        db.close()

        return redirect("/customers")

    except Exception as e:
        db.rollback()
        cursor.close()
        db.close()
        return f"Error deleting customer: {e}", 500

if __name__ == "__main__":
    app.run(debug=True)
