window.addEventListener("load", function(){
            document.body.classList.add('loaded');
            });
            // Function to preview uploaded images
                    function previewImages() {
                    const imageUpload = document.getElementById('imageUpload');
                            const imagePreview = document.getElementById('imagePreview');
                            imagePreview.innerHTML = ''; // Clear previous images

                            for (const file of imageUpload.files) {
                    const reader = new FileReader();
                            reader.onload = function(e) {
                            const img = document.createElement('img');
                                    img.src = e.target.result;
                                    img.classList.add('w-20', 'h-20', 'object-cover', 'rounded');
                                    imagePreview.appendChild(img);
                            };
                            reader.readAsDataURL(file);
                    }
                    }

            // Function to add more detail fields
            function addDetail() {
            const moreDetailsContainer = document.getElementById('moreDetailsContainer');
                    const detailItem = document.createElement('div');
                    detailItem.classList.add('detail-item', 'mb-4');
                    detailItem.innerHTML = `
                    <label class="block mb-2 text-sm font-medium text-gray-600"> Title </label>
                    <input type="text" class="w-full p-2 mb-2 border rounded" name="title" placeholder="Detail title">
                    <label class="block mb-2 text-sm font-medium text-gray-600" > Description </label>
                    <textarea class="w-full p-2 border rounded" rows="2" name="details" placeholder="Detail description"></textarea>
                    `;
                    moreDetailsContainer.appendChild(detailItem);
            }
            // Function to add more tenure fields
            function addTenure() {
            const nextTenureContainer = document.getElementById('nextTenureContainer');
                    const nextTenure = document.createElement('div');
                    nextTenure.classList.add('flex', 'mb-4', 'gap-2');
                    nextTenure.innerHTML = `
                    <input type="number" id="price" class="w-full p-2 border rounded" name="price" placeholder="Enter price" >
                    <select id="tenure" name="tenure" class="p-2 border rounded">
                    <option value="3"> 3 months </option>
                    <option value="6"> 6 months </option>
                    <option value="12"> 12 Months </option>
                    <option value="18"> 18 Months </option>
                    </select>
                    `;
                    nextTenureContainer.appendChild(nextTenure);
            }
            function addTag() {
            const tags = document.getElementById('tags');
            const tagInput = document.getElementById('tagInput');
            console.log(tagInput.value);
                    const tag = document.createElement('div');
                    tag.classList.add('flex', 'gap-2');
                    tag.innerHTML = `
                    <input value="${tagInput.value}" name="tag">
                    `;
                    tags.appendChild(tag);
            }