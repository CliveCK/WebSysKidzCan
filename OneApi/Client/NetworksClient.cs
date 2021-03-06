﻿using OneApi.Model;
using System.Collections.Generic;

namespace OneApi.Client
{
    public interface NetworksClient
    {
        /// <summary>
        /// Returns a list of networks.
        /// </summary>
        /// <returns>Network[]</returns>
        Network[] GetNetworks();

        NumberInfo ResolveMSISDN(string gsmNumber);

        NumberInfo[] ResolveMSISDNs(List<string> gsmNumbers);
    }
}
