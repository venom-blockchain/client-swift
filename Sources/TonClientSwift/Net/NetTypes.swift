public enum TSDKNetErrorCode: Int, Codable {
    case QueryFailed = 601
    case SubscribeFailed = 602
    case WaitForFailed = 603
    case GetSubscriptionResultFailed = 604
    case InvalidServerResponse = 605
    case ClockOutOfSync = 606
    case WaitForTimeout = 607
    case GraphqlError = 608
    case NetworkModuleSuspended = 609
    case WebsocketDisconnected = 610
    case NotSupported = 611
    case NoEndpointsProvided = 612
    case GraphqlWebsocketInitError = 613
    case NetworkModuleResumed = 614
}

public enum TSDKSortDirection: String, Codable {
    case ASC = "ASC"
    case DESC = "DESC"
}

public enum TSDKParamsOfQueryOperationEnumTypes: String, Codable {
    case QueryCollection = "QueryCollection"
    case WaitForCollection = "WaitForCollection"
    case AggregateCollection = "AggregateCollection"
    case QueryCounterparties = "QueryCounterparties"
}

public enum TSDKAggregationFn: String, Codable {
    case COUNT = "COUNT"
    case MIN = "MIN"
    case MAX = "MAX"
    case SUM = "SUM"
    case AVERAGE = "AVERAGE"
}

public struct TSDKOrderBy: Codable {
    public var path: String
    public var direction: TSDKSortDirection

    public init(path: String, direction: TSDKSortDirection) {
        self.path = path
        self.direction = direction
    }
}

public struct TSDKParamsOfQueryOperation: Codable {
    public var type: TSDKParamsOfQueryOperationEnumTypes

    public init(type: TSDKParamsOfQueryOperationEnumTypes) {
        self.type = type
    }
}

public struct TSDKFieldAggregation: Codable {
    /// Dot separated path to the field
    public var field: String
    /// Aggregation function that must be applied to field values
    public var fn: TSDKAggregationFn

    public init(field: String, fn: TSDKAggregationFn) {
        self.field = field
        self.fn = fn
    }
}

public struct TSDKTransactionNode: Codable {
    /// Transaction id.
    public var id: String
    /// In message id.
    public var in_msg: String
    /// Out message ids.
    public var out_msgs: [String]
    /// Account address.
    public var account_addr: String
    /// Transactions total fees.
    public var total_fees: String
    /// Aborted flag.
    public var aborted: Bool
    /// Compute phase exit code.
    public var exit_code: UInt32?

    public init(id: String, in_msg: String, out_msgs: [String], account_addr: String, total_fees: String, aborted: Bool, exit_code: UInt32? = nil) {
        self.id = id
        self.in_msg = in_msg
        self.out_msgs = out_msgs
        self.account_addr = account_addr
        self.total_fees = total_fees
        self.aborted = aborted
        self.exit_code = exit_code
    }
}

public struct TSDKMessageNode: Codable {
    /// Message id.
    public var id: String
    /// Source transaction id.
    /// This field is missing for an external inbound messages.
    public var src_transaction_id: String?
    /// Destination transaction id.
    /// This field is missing for an external outbound messages.
    public var dst_transaction_id: String?
    /// Source address.
    public var src: String?
    /// Destination address.
    public var dst: String?
    /// Transferred tokens value.
    public var value: String?
    /// Bounce flag.
    public var bounce: Bool
    /// Decoded body.
    /// Library tries to decode message body using provided `params.abi_registry`.
    /// This field will be missing if none of the provided abi can be used to decode.
    public var decoded_body: TSDKDecodedMessageBody?

    public init(id: String, src_transaction_id: String? = nil, dst_transaction_id: String? = nil, src: String? = nil, dst: String? = nil, value: String? = nil, bounce: Bool, decoded_body: TSDKDecodedMessageBody? = nil) {
        self.id = id
        self.src_transaction_id = src_transaction_id
        self.dst_transaction_id = dst_transaction_id
        self.src = src
        self.dst = dst
        self.value = value
        self.bounce = bounce
        self.decoded_body = decoded_body
    }
}

public struct TSDKParamsOfQuery: Codable {
    /// GraphQL query text.
    public var query: String
    /// Variables used in query.
    /// Must be a map with named values that can be used in query.
    public var variables: AnyValue?

    public init(query: String, variables: AnyValue? = nil) {
        self.query = query
        self.variables = variables
    }
}

public struct TSDKResultOfQuery: Codable {
    /// Result provided by DAppServer.
    public var result: AnyJSONType

    public init(result: AnyJSONType) {
        self.result = result
    }
}

public struct TSDKParamsOfBatchQuery: Codable {
    /// List of query operations that must be performed per single fetch.
    public var operations: [TSDKParamsOfQueryOperation]

    public init(operations: [TSDKParamsOfQueryOperation]) {
        self.operations = operations
    }
}

public struct TSDKResultOfBatchQuery: Codable {
    /// Result values for batched queries.
    /// Returns an array of values. Each value corresponds to `queries` item.
    public var results: [AnyJSONType]

    public init(results: [AnyJSONType]) {
        self.results = results
    }
}

public struct TSDKParamsOfQueryCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String
    /// Sorting order
    public var order: [TSDKOrderBy]?
    /// Number of documents to return
    public var limit: UInt32?

    public init(collection: String, filter: AnyValue? = nil, result: String, order: [TSDKOrderBy]? = nil, limit: UInt32? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.order = order
        self.limit = limit
    }
}

public struct TSDKResultOfQueryCollection: Codable {
    /// Objects that match the provided criteria
    public var result: [AnyJSONType]

    public init(result: [AnyJSONType]) {
        self.result = result
    }
}

public struct TSDKParamsOfAggregateCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var fields: [TSDKFieldAggregation]?

    public init(collection: String, filter: AnyValue? = nil, fields: [TSDKFieldAggregation]? = nil) {
        self.collection = collection
        self.filter = filter
        self.fields = fields
    }
}

public struct TSDKResultOfAggregateCollection: Codable {
    /// Values for requested fields.
    /// Returns an array of strings. Each string refers to the corresponding `fields` item.
    /// Numeric value is returned as a decimal string representations.
    public var values: AnyJSONType

    public init(values: AnyJSONType) {
        self.values = values
    }
}

public struct TSDKParamsOfWaitForCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String
    /// Query timeout
    public var timeout: UInt32?

    public init(collection: String, filter: AnyValue? = nil, result: String, timeout: UInt32? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.timeout = timeout
    }
}

public struct TSDKResultOfWaitForCollection: Codable {
    /// First found object that matches the provided criteria
    public var result: AnyJSONType

    public init(result: AnyJSONType) {
        self.result = result
    }
}

public struct TSDKResultOfSubscribeCollection: Codable {
    /// Subscription handle.
    /// Must be closed with `unsubscribe`
    public var handle: UInt32

    public init(handle: UInt32) {
        self.handle = handle
    }
}

public struct TSDKParamsOfSubscribeCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String

    public init(collection: String, filter: AnyValue? = nil, result: String) {
        self.collection = collection
        self.filter = filter
        self.result = result
    }
}

public struct TSDKParamsOfFindLastShardBlock: Codable {
    /// Account address
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKResultOfFindLastShardBlock: Codable {
    /// Account shard last block ID
    public var block_id: String

    public init(block_id: String) {
        self.block_id = block_id
    }
}

public struct TSDKEndpointsSet: Codable {
    /// List of endpoints provided by server
    public var endpoints: [String]

    public init(endpoints: [String]) {
        self.endpoints = endpoints
    }
}

public struct TSDKResultOfGetEndpoints: Codable {
    /// Current query endpoint
    public var query: String
    /// List of all endpoints used by client
    public var endpoints: [String]

    public init(query: String, endpoints: [String]) {
        self.query = query
        self.endpoints = endpoints
    }
}

public struct TSDKParamsOfQueryCounterparties: Codable {
    /// Account address
    public var account: String
    /// Projection (result) string
    public var result: String
    /// Number of counterparties to return
    public var first: UInt32?
    /// `cursor` field of the last received result
    public var after: String?

    public init(account: String, result: String, first: UInt32? = nil, after: String? = nil) {
        self.account = account
        self.result = result
        self.first = first
        self.after = after
    }
}

public struct TSDKParamsOfQueryTransactionTree: Codable {
    /// Input message id.
    public var in_msg: String
    /// List of contract ABIs that will be used to decode message bodies. Library will try to decode each returned message body using any ABI from the registry.
    public var abi_registry: [TSDKAbi]?

    public init(in_msg: String, abi_registry: [TSDKAbi]? = nil) {
        self.in_msg = in_msg
        self.abi_registry = abi_registry
    }
}

public struct TSDKResultOfQueryTransactionTree: Codable {
    /// Messages.
    public var messages: [TSDKMessageNode]
    /// Transactions.
    public var transactions: [TSDKTransactionNode]

    public init(messages: [TSDKMessageNode], transactions: [TSDKTransactionNode]) {
        self.messages = messages
        self.transactions = transactions
    }
}

