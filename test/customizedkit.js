const categories = [
    {
        categoryId: 1,
        name:"Bats",
        image:"products/gallery/1640619994_Bats.png"
    },
    {
        categoryId: 2,
        name:"Balls",
        image:"products/gallery/1640619994_Balls.png"
    },
    {
        categoryId: 5,
        subCategoryId: 6,
        name:"Batting Gloves",
        image:"products/gallery/1640619994_BattingGloves.png"
    },
    {
        categoryId: 5,
        subCategoryId: 7,
        name:"Batting Pads",
        image:"products/gallery/1640619994_BattingPads.png"
    },
    {
        categoryId: 5,
        subCategoryId: 8,
        name:"Batting Inner",
        image:"products/gallery/1640790858_BattingInner.png"
    },
    {
        categoryId: 5,
        subCategoryId: 9,
        name:"Batting Helmets",
        image:"products/gallery/1640619994_battinghelmets.png"
    },
    {
        categoryId: 5,
        subCategoryId: 42,
        name:"Abdominal Guard",
        image:"products/gallery/1640790858_Abdominalguard.png"
    },
    {
        categoryId: 5,
        subCategoryId: 43,
        name:"Thigh Guard",
        image:"products/gallery/1640790858_Thighguard.png"
    },
    {
        categoryId: 5,
        subCategoryId: 50,
        name:"Chest Guard",
        image:"products/gallery/1640790858_ChestGuard.png"
    },
    {
        categoryId: 5,
        subCategoryId: 44,
        name:"Elbow Guard",
        image:"products/gallery/1640790858_Elbowguard.png"
    },
    {
        categoryId: 11,
        name:"Shoes",
        image:"products/gallery/1640790858_Shoes.png"
    },
    {
        categoryId: 20,
        name:"Bags",
        image:"products/gallery/1640790858_Kitbag.png"
    },
    {
        categoryId: 13,
        subCategoryId: 14,
        name:"Keeping Gloves",
        image:"products/gallery/1640790858_KeepingGloves.png"
    },
    {
        categoryId: 13,
        subCategoryId: 15,
        name:"Keeping Pads",
        image:"products/gallery/1640790858_Keepingpads.png"
    },
    {
        categoryId: 13,
        subCategoryId: 16,
        name:"Keeping Inner",
        image:"products/gallery/1640790858_Keepinginners.png"
    }
]

var moment = require('moment-timezone');
console.log(moment(1640870793046).tz("Asia/Calcutta").format());
console.log(Number(moment(1640870793046).tz("America/Los_Angeles").format().substr(11,2)));
