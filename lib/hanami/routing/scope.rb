# frozen_string_literal: true

require "delegate"
require "hanami/utils/path_prefix"

module Hanami
  module Routing
    # Prefix for routes.
    # Implementation of Hanami::Router#prefix
    #
    # @since 2.0.0
    # @api private
    #
    # @see Hanami::Router#prefix
    class Scope < SimpleDelegator
      # @api private
      # @since 2.0.0
      def initialize(router, prefix, namespace, configuration, &blk)
        @router        = router
        @namespace     = namespace
        @configuration = configuration
        @prefix        = Utils::PathPrefix.new(prefix)
        __setobj__(@router)
        instance_eval(&blk)
      end

      def root(to:, as: :root, **, &blk)
        super(to: to, as: route_name(as), prefix: @prefix, namespace: @namespace, configuration: @configuration, &blk)
      end

      # @api private
      # @since 2.0.0
      def get(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def post(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def put(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def patch(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def delete(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def trace(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def options(path, as: nil, **options, &endpoint)
        super(@prefix.join(path), options.merge(as: route_name(as), namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def resource(name, options = {})
        super(name, options.merge(prefix: @prefix.relative_join(options[:prefix]), namespace: @namespace, configuration: @configuration))
      end

      # @api private
      # @since 2.0.0
      def resources(name, options = {})
        super(name, options.merge(prefix: @prefix.relative_join(options[:prefix]), namespace: @namespace, configuration: @configuration))
      end

      # @api private
      # @since 2.0.0
      def redirect(path, options = {}, &endpoint)
        super(@prefix.join(path), options.merge(to: @prefix.join(options[:to])), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def mount(app, options)
        super(app, options.merge(at: @prefix.join(options[:at])))
      end

      # @api private
      # @since 2.0.0
      def prefix(path, &blk)
        super(@prefix.join(path), namespace: @namespace, configuration: @configuration, &blk)
      end

      private

      ROUTE_NAME_SEPARATOR = "_"

      def route_name(as)
        @prefix.relative_join(as, ROUTE_NAME_SEPARATOR).to_sym unless as.nil?
      end
    end
  end
end