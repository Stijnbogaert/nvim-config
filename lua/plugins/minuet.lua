local enabled = false
if enabled then
return {
	'milanglacier/minuet-ai.nvim',
        dependencies = { { "nvim-lua/plenary.nvim" }, { "hrsh7th/nvim-cmp" } },
	opts = {
                virtualtext = {
                        auto_trigger_ft = {'*'},
                        keymap = {
                            -- accept whole completion
                            accept = '<C-A>',
                            -- accept one line
                            accept_line = '<A-a>',
                            -- accept n lines (prompts for number)
                            -- e.g. "A-z 2 CR" will accept 2 lines
                            accept_n_lines = '<A-z>',
                            -- Cycle to prev completion item, or manually invoke completion
                            prev = '<A-[>',
                            -- Cycle to next completion item, or manually invoke completion
                            next = '<A-]>',
                            dismiss = '<A-e>',
                        },
                },
            provider = 'openai_compatible',
            request_timeout = 2.5,
            throttle = 1500, -- Increase to reduce costs and avoid rate limits
            debounce = 600, -- Increase to reduce costs and avoid rate limits
            provider_options = {
                openai_compatible = {
                    api_key = 'OPENROUTER_MINUET_API_KEY',
                    end_point = 'https://openrouter.ai/api/v1/chat/completions',
                    model = 'moonshotai/kimi-dev-72b:free',
                    name = 'Openrouter',
                    optional = {
                        max_tokens = 56,
                        top_p = 0.9,
                        provider = {
                             -- Prioritize throughput for faster completion
                            sort = 'throughput',
                        },
                    },
                },
            },
        }
}
end
return {}
