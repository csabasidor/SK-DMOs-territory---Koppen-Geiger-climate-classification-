-- PostgreSQL stored procedure for looping through kg_layers and dmo_id
DO $$
DECLARE
    kg_layer TEXT;
    dmo_id BIGINT;
    l_dmo_id BIGINT[];
    -- Array of kg_layers
    kg_layers TEXT[] := ARRAY[
        --'sk_kg1901_1930'--, 
        --'sk_kg1931_1960'--, 
        --'sk_kg1961_1990'--, 
        --'sk_kg1991_2020'--, 
        --'sk_kg2041_2070_ssp585'--, 
        'sk_kg2071_2099_ssp585'
    ];
BEGIN
    -- Retrieve all distinct dmo_id into an array
    SELECT ARRAY_AGG(sk_dmos_geom.dmo_id ORDER BY sk_dmos_geom.dmo_id) INTO l_dmo_id
    FROM gtlab.sk_dmos_geom;

    -- Loop through each kg_layer
    FOREACH kg_layer IN ARRAY kg_layers LOOP

        -- Loop through each dmo_id
        FOREACH dmo_id IN ARRAY l_dmo_id LOOP

            -- Notice the current kg_layer and dmo_id being processed
            RAISE NOTICE 'Working on kg_layer: %, dmo_id: %', kg_layer, dmo_id;

            -- Check if the table exists
            IF EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_schema = 'gtlab' 
                AND table_name = format('%I_intersection', kg_layer)
            ) THEN
                -- Insert data into the existing table
                EXECUTE format(
                    'INSERT INTO gtlab.%I_intersection
                    SELECT 
                        sk_dmos_geom.dmo_id, 
                        %I.band_id, 
						%I.hex,
						%I.name, 
					    SUM(ST_Area(ST_Transform(sk_dmos_geom.geom, 4326))) AS area_dmo,
                        SUM(ST_Area(%I.grid_geom)) AS area_grid,
                        SUM(ST_Area(ST_Intersection(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom))) AS area_of_intersection,
                        SUM(ST_Area(ST_Intersection(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom)) / NULLIF(ST_Area(ST_Transform(sk_dmos_geom.geom, 4326)), 0)) AS weight_of_intersection,
                        ST_Union(%I.grid_geom) AS kg_intersection_geom
                    FROM 
                        gtlab.%I,
                        gtlab.sk_dmos_geom
                    WHERE 
                        sk_dmos_geom.dmo_id = %L AND
                        ST_Intersects(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom)
                    GROUP BY 
                        sk_dmos_geom.dmo_id, 
                        %I.band_id,
						%I.hex,
						%I.name',
                    quote_ident(kg_layer), kg_layer, kg_layer,kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, dmo_id, kg_layer, kg_layer, kg_layer, kg_layer
                );
            ELSE
                -- Create table and insert data if the table does not exist
                EXECUTE format(
                    'CREATE TABLE gtlab.%I_intersection AS 
                    SELECT 
                        sk_dmos_geom.dmo_id, 
                        %I.band_id, 
						%I.hex,
						%I.name, 
                        SUM(ST_Area(ST_Transform(sk_dmos_geom.geom, 4326))) AS area_dmo,
                        SUM(ST_Area(%I.grid_geom)) AS area_grid,
                        SUM(ST_Area(ST_Intersection(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom))) AS area_of_intersection,
                        SUM(ST_Area(ST_Intersection(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom)) / NULLIF(ST_Area(ST_Transform(sk_dmos_geom.geom, 4326)), 0)) AS weight_of_intersection,
                        ST_Union(%I.grid_geom) AS kg_intersection_geom
                    FROM 
                        gtlab.%I,
                        gtlab.sk_dmos_geom
                    WHERE 
                        sk_dmos_geom.dmo_id = %L AND
                        ST_Intersects(ST_Transform(sk_dmos_geom.geom, 4326), %I.grid_geom)
                    GROUP BY 
                        sk_dmos_geom.dmo_id, 
                        %I.band_id,
						%I.hex,
						%I.name',
                    quote_ident(kg_layer), kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, kg_layer, dmo_id, kg_layer, kg_layer, kg_layer, kg_layer
                );
            END IF;

        END LOOP; -- End of dmo_id loop

    END LOOP; -- End of kg_layer loop

END $$;
