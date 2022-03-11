const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const {
	DB_ERROR_CATEGORIES_FETCH,
	DB_ERROR_CATEGORY_DETAIL_FETCH,
	DB_ERROR_PRODUCTS_FILTER_FETCH
} = require("../lib/error/errors.json");

// category parent_id must be 0
const SQL_FETCH_CATEGORIES = "CALL SP_fetch_categories()";
const SQL_FETCH_CATEGORY_DETAIL = "CALL SP_fetch_category_detail(?)";
const SQL_FETCH_PRODUCTS_FILTER = "CALL SP_fetch_products_filter(?,?)";

router.get('/',
	(req, res) => {
		db.query(SQL_FETCH_CATEGORIES, [],
			(err, results) => {
				if (err) {
					return sendError(res, DB_ERROR_CATEGORIES_FETCH, err);
				}
				else {
					logger.debug(results[0]);
					const categories = results[0].map(({ id, name, image }) => {
						return {
							id, name, image
						}
					});
					return res.json({ data: { categories } });
				}
			}
		);
	}
);

router.get('/:categoryId',
	(req, res, next) => {
		logger.debug('Fetch category detail');
		const categoryId = Number(req.params.categoryId);
		req._data = { input: { categoryId } };
		next();
	},
	(req, res, next) => {
		const { categoryId } = req._data.input;
		db.query(SQL_FETCH_CATEGORY_DETAIL, [categoryId],
			(err, results) => {
				if (err) {
					return sendError(res, DB_ERROR_CATEGORY_DETAIL_FETCH, err);
				}
				else {
					let subCategories = [];
					let category = {
						id: results[0][0].id,
						name: results[0][0].name,
						image: results[0][0].image,
						parentId: results[0][0].parent_id,
					};
					if (results[0][0].sub_category_id) {
						subCategories = results[0].map(({ sub_category_id, sub_category_name }) => {
							return { id: sub_category_id, name: sub_category_name };
						});
					}
					category.subCategories = subCategories;
					if (!category.subCategories.length) {
						req._data.middleware = { category };
						next();
					}
					else {
						return res.json({ data: { category } });
					}
				}
			}
		);
	},
	(req, res) => {
		let { category } = req._data.middleware;
		const categoryId = category.parentId == 0 ? category.id : null;
		const subCategoryId = category.parentId == 0 ? null : category.id;
		db.query(SQL_FETCH_PRODUCTS_FILTER, [categoryId, subCategoryId],
			(err, results) => {
				if (err) {
					return sendError(res, DB_ERROR_PRODUCTS_FILTER_FETCH, err);
				}
				else {
					const brand = new Set(results[0].filter(item => item.brand != null).map(({ brand }) => brand));
					const idealFor = new Set(results[0].filter(item => item.ideal_for != null).map(({ ideal_for }) => ideal_for));
					const size = new Set(results[0].filter(item => item.size != null).map(({ size }) => size));
					const color = new Set(results[0].filter(item => item.color != null).map(({ color }) => color));
					const materialType = new Set(results[0].filter(item => item.material_type != null).map(({ material_type }) => material_type));
					const handleType = new Set(results[0].filter(item => item.handle_type != null).map(({ handle_type }) => handle_type));
					const styleType = new Set(results[0].filter(item => item.style_type != null).map(({ style_type }) => style_type));
					const price = Math.max(...results[0].map(({ price }) => price));
					return res.json({
						data: {
							category: {
								id: category.id,
								name: category.name,
								image: category.image,
								subCategories: category.subCategories,
								filter: {
									brand: Array.from(brand).map(item => ({ value: item })),
									idealFor: Array.from(idealFor).map(item => ({ value: item })),
									size: Array.from(size).map(item => ({ value: item })),
									color: Array.from(color).map(item => ({ value: item })),
									materialType: Array.from(materialType).map(item => ({ value: item })),
									handleType: Array.from(handleType).map(item => ({ value: item })),
									styleType: Array.from(styleType).map(item => ({ value: item })),
									price: [{ value: price }]
								}
							}
						}
					});
				}
			}
		);
	}
)

module.exports = router;