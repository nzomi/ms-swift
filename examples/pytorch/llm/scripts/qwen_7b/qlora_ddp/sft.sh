# 4 * 16GB VRAM
nproc_per_node=4
CUDA_VISIBLE_DEVICES=0,1,2,3 \
torchrun \
    --nproc_per_node=$nproc_per_node \
    --master_port 29500 \
    src/llm_sft.py \
    --model_type qwen-7b \
    --sft_type lora \
    --dtype bf16 \
    --output_dir runs \
    --ddp_backend nccl \
    --dataset alpaca-en,alpaca-zh \
    --dataset_sample -1 \
    --num_train_epochs 1 \
    --max_length 1024 \
    --quantization_bit 4 \
    --lora_rank 64 \
    --lora_alpha 32 \
    --lora_dropout_p 0.05 \
    --lora_target_modules ALL \
    --batch_size 1 \
    --weight_decay 0. \
    --learning_rate 1e-4 \
    --gradient_accumulation_steps $(expr 16 / $nproc_per_node) \
    --max_grad_norm 0.5 \
    --warmup_ratio 0.03 \
    --eval_steps 50 \
    --save_steps 50 \
    --save_total_limit 2 \
    --logging_steps 10 \
    --use_flash_attn false \
    --push_to_hub false \
    --hub_model_id qwen-7b-qlora \
    --hub_private_repo true \
    --hub_token 'your-sdk-token' \
