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

/* let sql = '';
Object.entries(categoryMap).forEach(([k, v]) => {
    sql = `${sql}\n(${Number(k)},"${v.name}",1,5,${v.parent}),`;
});
console.log(sql);
 */
let sql = 'Update Categories set name';
Object.entries(categoryMap).forEach(([k, v]) => {
    sql = `${sql}\n Update categories set name = "${v.name}", parent_id = ${Number(v.parent)} WHERE  id = ${Number(k)};`;
});
console.log(sql);

/* let x = [];
Object.entries(categoryMap).forEach(([k, v]) => {
    if (v.parent === 0) x.push({ id: Number(k), name: v.name, image: v.image });
});

console.log(x); */

/*
let child = 2;
let x = [];
let z;
Object.entries(categoryMap).forEach(([k, v]) => {
    if (Number(k) === child) {
        z = {
            id: Number(k),
            name: v.name,
            image: v.image,
            filter: v.filter
        };
    }
    if (v.parent === child) x.push({ id: Number(k), name: v.name, image: v.image });
});
z.subCategories = x;

let parent;
Object.entries(categoryMap).forEach(([k, v]) => {
    if (v.subCategories.includes(child)) {
        z.filter = [...z.filter, ...v.filter];
        parent = Number(k);
    }
});

if (parent) {
    Object.entries(categoryMap).forEach(([k, v]) => {
        if (v.subCategories.includes(parent)) {
            z.filter = [...z.filter, ...v.filter];
        }
    });
}

console.log(z);
*/

/*
REPLACE INTO `categories`(id,name,business_id, created_by,parent_id) VALUES
(1,"Bats",1,5,0),
(2,"Balls",1,5,0),
(3,"Training Balls",1,5,2),   
(4,"Leather Balls",1,5,2),    
(5,"Batting Equipment",1,5,0),
(6,"Batting Gloves",1,5,5),   
(7,"Batting Pads",1,5,5),     
(8,"Batting Inner",1,5,5),
(9,"Batting Helmets",1,5,5),
(10,"Batting Protection",1,5,5),
(11,"Shoes",1,5,0),
(12,"Rubber Spike",1,5,11),
(13,"Keeping Equipment",1,5,0),
(14,"Keeping Gloves",1,5,13),
(15,"Keeping Pads",1,5,13),
(16,"Keeping Inner",1,5,13),
(17,"Clothing",1,5,0),
(18,"Hats & Caps",1,5,17),
(19,"Whites",1,5,17),
(20,"Bags",1,5,0),
(21,"Duffle Bags",1,5,20),
(22,"Wheel Bags",1,5,20),
(23,"Kit Bags",1,5,20),
(24,"Backpacks",1,5,20),
(25,"Accessories",1,5,0),
(26,"Bat Care",1,5,25),
(27,"Grips",1,5,25),
(28,"Scorecard",1,5,25),
(29,"Umpiring Tools",1,5,25),
(30,"Robo Arm",1,5,25),
(31,"Stumps",1,5,25),
(32,"Training",1,5,25),
(33,"Cricket Socks",1,5,25);
*/


