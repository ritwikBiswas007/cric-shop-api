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
            2,
            3
        ]
    },
    "2": {
        "parent": 1,
        "name": "Adults Bats",
        "image": "Adult",
        "filter": [],
        "subCategories": []
    },
    "3": {
        "parent": 1,
        "name": "Kids Bats",
        "image": "Kids",
        "filter": [],
        "subCategories": []
    },
    "4": {
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
            5,
            6,
            7,
            8,
            9
        ]
    },
    "5": {
        "parent": 4,
        "name": "Adults Balls",
        "image": "Adult",
        "filter": [],
        "subCategories": [
            7,
            8
        ]
    },
    "6": {
        "parent": 4,
        "name": "Kids Balls",
        "image": "Kids",
        "filter": [],
        "subCategories": [
            9
        ]
    },
    "7": {
        "parent": 5,
        "name": "Training Balls",
        "image": "Training",
        "filter": [],
        "subCategories": []
    },
    "8": {
        "parent": 5,
        "name": "Leather Balls",
        "image": "Leather",
        "filter": [],
        "subCategories": []
    },
    "9": {
        "parent": 6,
        "name": "Leather Balls",
        "image": "Leather",
        "filter": [],
        "subCategories": []
    },
    "10": {
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
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22
        ]
    },
    "11": {
        "parent": 10,
        "name": "Adults Batting Equipment",
        "image": "Adult",
        "filter": [],
        "subCategories": [
            13,
            14,
            15,
            16,
            17
        ]
    },
    "12": {
        "parent": 10,
        "name": "Kids Batting Equipment",
        "image": "Kids",
        "filter": [],
        "subCategories": [
            18,
            19,
            20,
            21,
            22
        ]
    },
    "13": {
        "parent": 11,
        "name": "Batting Gloves",
        "image": "Batting Glove",
        "filter": [],
        "subCategories": []
    },
    "14": {
        "parent": 11,
        "name": "Batting Pads",
        "image": "Batting Pad",
        "filter": [],
        "subCategories": []
    },
    "15": {
        "parent": 11,
        "name": "Batting Inner",
        "image": "Batting Inner",
        "filter": [],
        "subCategories": []
    },
    "16": {
        "parent": 11,
        "name": "Batting Helmets",
        "image": "Batting Helmet",
        "filter": [],
        "subCategories": []
    },
    "17": {
        "parent": 11,
        "name": "Batting Protection",
        "image": "Batting Protection",
        "filter": [],
        "subCategories": []
    },
    "18": {
        "parent": 12,
        "name": "Batting Gloves",
        "image": "Batting Glove",
        "filter": [],
        "subCategories": []
    },
    "19": {
        "parent": 12,
        "name": "Batting Pads",
        "image": "Batting Pad",
        "filter": [],
        "subCategories": []
    },
    "20": {
        "parent": 12,
        "name": "Batting Inner",
        "image": "Batting Inner",
        "filter": [],
        "subCategories": []
    },
    "21": {
        "parent": 12,
        "name": "Batiing Helmets",
        "image": "Batting Helmets",
        "filter": [],
        "subCategories": []
    },
    "22": {
        "parent": 12,
        "name": "Batting Protection",
        "image": "Protection",
        "filter": [],
        "subCategories": []
    },
    "23": {
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
            24,
            25,
            26,
            27
        ]
    },
    "24": {
        "parent": 23,
        "name": "Adults Shoes ",
        "image": "Adult",
        "filter": [],
        "subCategories": [
            26
        ]
    },
    "25": {
        "parent": 23,
        "name": "Kids Shoes",
        "image": "Kids",
        "filter": [],
        "subCategories": [
            27
        ]
    },
    "26": {
        "parent": 24,
        "name": "Rubber Spike",
        "image": "Rubber Spike",
        "filter": [],
        "subCategories": []
    },
    "27": {
        "parent": 25,
        "name": "Rubber Spike",
        "image": "Rubber Spike",
        "filter": [],
        "subCategories": []
    },
    "28": {
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
            29,
            30,
            31,
            32,
            33,
            34,
            35,
            36
        ]
    },
    "29": {
        "parent": 28,
        "name": "Adults Keeping Equipment",
        "image": "Adult",
        "filter": [],
        "subCategories": [
            31,
            32,
            33,
            53
        ]
    },
    "30": {
        "parent": 28,
        "name": "Kids Keeping Equipment",
        "image": "Kids",
        "filter": [],
        "subCategories": [
            34,
            35,
            36,
            54
        ]
    },
    "31": {
        "parent": 29,
        "name": "Keeping Gloves",
        "image": "Keeping Glove",
        "filter": [],
        "subCategories": []
    },
    "32": {
        "parent": 29,
        "name": "Keeping Pads",
        "image": "Keeping Pad",
        "filter": [],
        "subCategories": []
    },
    "33": {
        "parent": 29,
        "name": "Keeping Inner",
        "image": "Keeping Inner",
        "filter": [],
        "subCategories": []
    },
    "34": {
        "parent": 30,
        "name": "Keeping Gloves",
        "image": "Keeping Glove",
        "filter": [],
        "subCategories": []
    },
    "35": {
        "parent": 30,
        "name": "Keeping Pads",
        "image": "Keeping Pad",
        "filter": [],
        "subCategories": []
    },
    "36": {
        "parent": 30,
        "name": "Keeping Inner",
        "image": "Keeping Inner",
        "filter": [],
        "subCategories": []
    },
    "37": {
        "parent": 0,
        "name": "Clothing",
        "image": "Clothing",
        "filter": [],
        "subCategories": [
            38,
            39
        ]
    },
    "38": {
        "parent": 37,
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
    "39": {
        "parent": 37,
        "name": "Whites",
        "image": "Whites",
        "filter": [],
        "subCategories": []
    },
    "40": {
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
            41,
            42,
            43,
            55
        ]
    },
    "41": {
        "parent": 40,
        "name": "Duffle Bags",
        "image": "Duffle",
        "filter": [],
        "subCategories": []
    },
    "42": {
        "parent": 40,
        "name": "Wheel Bags",
        "image": "Wheel",
        "filter": [],
        "subCategories": []
    },
    "43": {
        "parent": 40,
        "name": "Backpacks",
        "image": "Backpacks",
        "filter": [],
        "subCategories": []
    },
    "44": {
        "parent": 0,
        "name": "Accessories",
        "image": "Accessories",
        "filter": [],
        "subCategories": [
            45,
            46,
            47,
            48,
            49,
            50,
            51,
            52
        ]
    },
    "45": {
        "parent": 43,
        "name": "Bat Care",
        "image": "Bat Care",
        "filter": [],
        "subCategories": []
    },
    "46": {
        "parent": 43,
        "name": "Grips",
        "image": "Grips",
        "filter": [],
        "subCategories": []
    },
    "47": {
        "parent": 43,
        "name": "Scorecard",
        "image": "Scorecard",
        "filter": [],
        "subCategories": []
    },
    "48": {
        "parent": 43,
        "name": "Umpiring Tools",
        "image": "Umpiring Tools",
        "filter": [],
        "subCategories": []
    },
    "49": {
        "parent": 43,
        "name": "Robo Arm",
        "image": "Robo Arm",
        "filter": [],
        "subCategories": []
    },
    "50": {
        "parent": 43,
        "name": "Stumps",
        "image": "Stumps",
        "filter": [],
        "subCategories": []
    },
    "51": {
        "parent": 43,
        "name": "Training",
        "image": "Training",
        "filter": [],
        "subCategories": []
    },
    "52": {
        "parent": 43,
        "name": "Cricket Socks",
        "image": "Cricket Socks",
        "filter": [],
        "subCategories": []
    },
    "53": {
        "parent": 29,
        "name": "Keeping Pads",
        "image": "Keeping Pads",
        "filter": [],
        "subCategories": []
    },
    "54": {
        "parent": 30,
        "name": "Keeping Pads",
        "image": "Keeping Pads",
        "filter": [],
        "subCategories": []
    },
    "55": {
        "parent": 40,
        "name": "Kit Bags",
        "image": "Kit Bags",
        "filter": [],
        "subCategories": []
    }
}


let sql = '';
Object.entries(categoryMap).forEach(([k, v]) => {
    sql = `${sql}\n(${Number(k)},"${v.name}",1,5,${v.parent}),`;
});
console.log(sql); 

/* let sql = 'Update Categories set name';
Object.entries(categoryMap).forEach(([k, v]) => {
    sql = `${sql}\n Update categories set name = "${v.name}", parent_id = ${Number(v.parent)} WHERE  id = ${Number(k)};`;
});
console.log(sql); */

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


