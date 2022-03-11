const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const {
	DB_ERROR_PRODUCTS_FETCH,
	DB_ERROR_PRODUCT_DETAIL_FETCH
} = require("../lib/error/errors.json");

const SQL_FETCH_PRODUCTS = 'CALL SP_fetch_products(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
const SQL_FETCH_PRODUCT_DETAIL = 'CALL SP_fetch_product_detail(?)';

router.get('/',
	(req, res, next) => {
		logger.debug('Fetch products list');
		let { categoryId, subCategoryId, name, brand, idealFor, materialType, handleType, styleType, size, color, priceGte, priceLte, page, perPage } = req.query;
		if (Array.isArray(categoryId)) categoryId = categoryId.join(",");
		if (Array.isArray(subCategoryId)) subCategoryId = subCategoryId.join(",");
		if (Array.isArray(brand)) brand = brand.join(",");
		if (Array.isArray(idealFor)) idealFor = idealFor.join(",");
		if (Array.isArray(materialType)) materialType = materialType.join(",");
		if (Array.isArray(handleType)) handleType = handleType.join(",");
		if (Array.isArray(styleType)) styleType = styleType.join(",");
		if (Array.isArray(size)) size = size.join(",");
		if (Array.isArray(color)) color = color.join(",");
		let priceAsc = true, ratingDesc = true, newestFirst = true;
		if (req.query.hasOwnProperty('priceDesc')) priceAsc = false;
		if (req.query.hasOwnProperty('ratingAsc')) ratingDesc = false;
		if (req.query.hasOwnProperty('oldestFirst')) newestFirst = false;
		if (!page) page = 0;
		if (!perPage) perPage = 20;
		req._data = { input: { categoryId, subCategoryId, name, brand, idealFor, materialType, handleType, styleType, size, color, priceGte, priceLte, priceAsc, ratingDesc, newestFirst, page, perPage } };
		next();
	},
	(req, res, next) => {
		const { categoryId, subCategoryId, name, brand, idealFor, materialType, handleType, styleType, size, color, priceGte, priceLte, priceAsc, ratingDesc, newestFirst, page, perPage } = req._data.input;
		db.query(SQL_FETCH_PRODUCTS, [categoryId, subCategoryId, name, brand, idealFor, materialType, handleType, styleType, size, color, priceGte, priceLte, priceAsc, ratingDesc, newestFirst, page, perPage],
			(err, results) => {
				if (err) {
					return sendError(res, DB_ERROR_PRODUCTS_FETCH, err);
				}
				else {
					const products = results[0].map(item => {
						return {
							id: item.id,
							name: item.name,
							image: item.image,
							rating: item.rating,
							variants: [
								{
									id: item.variation_id,
									name: item.variation_name,
									regularPrice: {
										unit: "$",
										value: item.regular_price
									},
									salePrice: {
										unit: "$",
										value: item.sale_price
									},
									availableStock: item.qty_available,
									image: item.variant_image
								}
							]
						}
					})
					return res.json({ data: { products } });
				}
			}
		)
	}
);

router.get('/:productId',
	(req, res) => {
		logger.debug('Fetch product detail');
		const productId = Number.parseInt(req.params.productId);

		db.query(SQL_FETCH_PRODUCT_DETAIL, [productId],
			(err, results) => {
				if (err) {
					return sendError(res, DB_ERROR_PRODUCT_DETAIL_FETCH, err);
				}
				else {
					let finalProduct;
					results[0].forEach(item => {
						// new product
						if (!finalProduct) {
							finalProduct = {
								id: item.id,
								name: item.name,
								image: item.image,
								gallery: item.gallery ? item.gallery.split(",").map(item => `products/gallery/${item}`) : [],
								description: item.long_description,
								shortDescription: item.product_description,
								additionalInformation: item.additional_information,
								idealFor: item.ideal_for,
								materialType: item.material_type,
								handleType: item.handle_type,
								styleType: item.style_type,
								rating: item.rating,
								tags: item.tags,
								length: {
									unit: "cm",
									value: Number(item.length)
								},
								height: {
									unit: "cm",
									value: Number(item.height)
								},
								width: {
									unit: "cm",
									value: Number(item.width)
								},
								weight: {
									unit: "gm",
									value: Number(item.weight)
								},
								unit: {
									id: item.unit_id,
									name: item.unit_name
								},
								category: {
									id: item.category_id,
									name: item.category_name
								},
								brand: {
									id: item.brand_id,
									name: item.brand_name
								},

								variants: [
									{
										id: item.variation_id,
										name: item.variation_name,
										size: item.size,
										color: item.color,
										regularPrice: {
											unit: "$",
											value: item.regular_price
										},
										salePrice: {
											unit: "$",
											value: item.sale_price
										},
										availableStock: item.qty_available,
										image: item.variant_image
									}
								]
							};
						} else {
							// add variants if not exists
							if (!finalProduct.variants.find((e) => e.id === item.variant_id)) {
								finalProduct.variants = [...finalProduct.variants, {
									id: item.variation_id,
									name: item.variation_name,
									size: item.size,
									color: item.color,
									regularPrice: {
										unit: "$",
										value: item.sell_price_inc_tax
									},
									salePrice: {
										unit: "$",
										value: item.sell_price_inc_tax
									},
									availableStock: item.qty_available,
									image: item.variant_image
								}];
							}
						}
					});
					return res.json({ data: { product: finalProduct } });
				}
			}
		)
	}
);

module.exports = router;