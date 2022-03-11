const categoryMap = {
    "1": {
        "parent": 0,
        "name": "Bats",
        "image": "Bat",
        "filter": [
            "Brand",
            "Ideal For",
            "Material Type",
            "Handle Type",
            "Color"
        ],
        "subCategories": [
        ]
    },
    "2": {
        "parent": 0,
        "name": "Balls",
        "image": "Ball",
        "filter": [
            "Brand",
            "Ideal For",
            "Material Type",
            "Color"
        ],
        "subCategories": [
            3, 4
        ]
    },
    "3": {
        "parent": 2,
        "name": "Training Balls",
        "image": "Training",
        "filter": [],
        "subCategories": []
    },
    "4": {
        "parent": 2,
        "name": "Leather Balls",
        "image": "Leather",
        "filter": [],
        "subCategories": []
    },
    "5": {
        "parent": 0,
        "name": "Batting Equipment",
        "image": "Batting Equipment",
        "filter": [
            "Brand",
            "Ideal For",
            "Size",
            "Material Type",
            "Color"
        ],
        "subCategories": [
            6, 7, 8, 9, 10
        ]
    },
    "6": {
        "parent": 5,
        "name": "Batting Gloves",
        "image": "Batting Glove",
        "filter": [],
        "subCategories": []
    },
    "7": {
        "parent": 5,
        "name": "Batting Pads",
        "image": "Batting Pad",
        "filter": [],
        "subCategories": []
    },
    "8": {
        "parent": 5,
        "name": "Batting Inner",
        "image": "Batting Inner",
        "filter": [],
        "subCategories": []
    },
    "9": {
        "parent": 5,
        "name": "Batting Helmets",
        "image": "Batting Helmet",
        "filter": [],
        "subCategories": []
    },
    "10": {
        "parent": 5,
        "name": "Batting Protection",
        "image": "Batting Protection",
        "filter": [],
        "subCategories": []
    },
    "11": {
        "parent": 0,
        "name": "Shoes",
        "image": "Shoe",
        "filter": [
            "Brand",
            "Ideal For",
            "Size",
            "Material Type",
            "Color"
        ],
        "subCategories": [
            12
        ]
    },
    "12": {
        "parent": 11,
        "name": "Rubber Spike",
        "image": "Rubber Spike",
        "filter": [],
        "subCategories": []
    },
    "13": {
        "parent": 0,
        "name": "Keeping Equipment",
        "image": "Keeping Equipment",
        "filter": [
            "Brand",
            "Ideal For",
            "Size",
            "Material Type",
            "Color"
        ],
        "subCategories": [
            14, 15, 16
        ]
    },
    "14": {
        "parent": 13,
        "name": "Keeping Gloves",
        "image": "Keeping Glove",
        "filter": [],
        "subCategories": []
    },
    "15": {
        "parent": 13,
        "name": "Keeping Pads",
        "image": "Keeping Pad",
        "filter": [],
        "subCategories": []
    },
    "16": {
        "parent": 13,
        "name": "Keeping Inner",
        "image": "Keeping Inner",
        "filter": [],
        "subCategories": []
    },
    "17": {
        "parent": 0,
        "name": "Clothing",
        "image": "Clothing",
        "filter": [],
        "subCategories": [
            18, 19
        ]
    },
    "18": {
        "parent": 17,
        "name": "Hats & Caps",
        "image": "Hats & Caps",
        "filter": [
            "Brand",
            "Ideal For",
            "Size",
            "Material Type",
            "Color"
        ],
        "subCategories": []
    },
    "19": {
        "parent": 17,
        "name": "Whites",
        "image": "Whites",
        "filter": [],
        "subCategories": []
    },
    "20": {
        "parent": 0,
        "name": "Bags",
        "image": "Bags",
        "filter": [
            "Brand",
            "Style Type",
            "Size",
            "Material Type",
            "Color"
        ],
        "subCategories": [
            21,
            22,
            23,
            24
        ]
    },
    "21": {
        "parent": 20,
        "name": "Duffle Bags",
        "image": "Duffle",
        "filter": [],
        "subCategories": []
    },
    "22": {
        "parent": 20,
        "name": "Wheel Bags",
        "image": "Wheel",
        "filter": [],
        "subCategories": []
    },
    "23": {
        "parent": 20,
        "name": "Kit Bags",
        "image": "Kit Bags",
        "filter": [],
        "subCategories": []
    },
    "24": {
        "parent": 20,
        "name": "Backpacks",
        "image": "Backpacks",
        "filter": [],
        "subCategories": []
    },
    "25": {
        "parent": 0,
        "name": "Accessories",
        "image": "Accessories",
        "filter": [],
        "subCategories": [
            26,
            27,
            28,
            29,
            30,
            31,
            32,
            33
        ]
    },
    "26": {
        "parent": 25,
        "name": "Bat Care",
        "image": "Bat Care",
        "filter": [],
        "subCategories": []
    },
    "27": {
        "parent": 25,
        "name": "Grips",
        "image": "Grips",
        "filter": [],
        "subCategories": []
    },
    "28": {
        "parent": 25,
        "name": "Scorecard",
        "image": "Scorecard",
        "filter": [],
        "subCategories": []
    },
    "29": {
        "parent": 25,
        "name": "Umpiring Tools",
        "image": "Umpiring Tools",
        "filter": [],
        "subCategories": []
    },
    "30": {
        "parent": 25,
        "name": "Robo Arm",
        "image": "Robo Arm",
        "filter": [],
        "subCategories": []
    },
    "31": {
        "parent": 25,
        "name": "Stumps",
        "image": "Stumps",
        "filter": [],
        "subCategories": []
    },
    "32": {
        "parent": 25,
        "name": "Training",
        "image": "Training",
        "filter": [],
        "subCategories": []
    },
    "33": {
        "parent": 25,
        "name": "Cricket Socks",
        "image": "Cricket Socks",
        "filter": [],
        "subCategories": []
    }
}

/**
 * 
 * @returns 
 */
function getCategoryList() {
    let categories = [];
    Object.entries(categoryMap).forEach(([k, v]) => {
        if (v.parent === 0) categories.push({ id: Number(k), name: v.name, image: v.image });
    });
    return categories;
}

/**
 * 
 * @param {number} categoryId 
 * @returns 
 */
function getCategoryDetail(categoryId) {
    let child = Number(categoryId);
    let subCategories = [];
    let category = {
        id: child,
        name: categoryMap[child].name,
        image: categoryMap[child].image
    };
    /* Object.entries(categoryMap).forEach(([k, v]) => {
        if (v.parent === child) subCategories.push({ id: Number(k), name: v.name, image: v.image });
    });
    category.subCategories = subCategories; */
    categoryMap[child].subCategories.forEach((id) => {
        if (categoryMap[id].parent == categoryId) {
            subCategories.push({
                id: id,
                name: categoryMap[id].name
            });
        }
    });
    category.subCategories = subCategories;

    if (!category.subCategories.length) {
        category.filter = categoryMap[child].filter
        let parent;
        Object.entries(categoryMap).forEach(([k, v]) => {
            if (v.subCategories.includes(child)) {
                category.filter = [...category.filter, ...v.filter];
                parent = Number(k);
            }
        });

        if (parent) {
            Object.entries(categoryMap).forEach(([k, v]) => {
                if (v.subCategories.includes(parent)) {
                    category.filter = [...category.filter, ...v.filter];
                }
            });
        }
    }

    return category;
}

/**
 * 
 * @param {number} categoryId 
 * @returns 
 */
function getSubCategoryIds(categoryId) {
    return categoryMap[categoryId].subCategories;
}

/**
 * Generate OTP
 * @param {Integer} numberOfDigit 
 */
function generateOTP(numberOfDigit = 6) {
    return Math.floor(100000 + Math.random() * 900000);
}

module.exports = { getCategoryList, getCategoryDetail, getSubCategoryIds, generateOTP };